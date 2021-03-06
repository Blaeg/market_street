# == Class Info
#
#  Every monetary charge creates an invoice.  Thus when you charge a customer XYZ,
#  you are actually using an invoice for the charge and not the order.  This allows
#  flexibility within accounting and returns and even some new charge that will be made
#  in the future.  If the system was only doing Cash-Based account the Invoices table
#  would be the only table needed.  NOTE: DO NOT THINK FOR A SECOND CASH BASED ACCOUNT IS GOOD ENOUGH!


# == Schema Information
#
# Table name: invoices
#
#  id              :integer(4)      not null, primary key
#  order_id        :integer(4)      not null
#  amount          :decimal(8, 2)   not null
#  invoice_type    :string(255)     default("Purchase"), not null
#  state           :string(255)     not null
#  active          :boolean(1)      default(TRUE), not null
#  created_at      :datetime
#  updated_at      :datetime
#  credited_amount :decimal(8, 2)   default(0.0)
#

class Invoice < ActiveRecord::Base
  require_dependency 'invoice/states'
  include Invoice::States

  has_many :payments
  belongs_to :order


  validates :amount,        :presence => true
  validates :invoice_type,  :presence => true
  #validates :order_id,      :presence => true

  PURCHASE  = 'Purchase'
  RMA       = 'RMA'

  INVOICE_TYPES = [PURCHASE, RMA]
  NUMBER_SEED     = 3002001004005
  CHARACTERS_SEED = 20

  delegate :user_id, :user, :to => :order

  #  the full shipping address as an array compacted.
  #
  # @param [none]
  # @return [Array]  has ("name", "address1", "address2"(unless nil), "city state zip") or nil
  def order_ship_address_lines
    order.ship_address.try(:full_address_array)
  end

  #  the full order address as an array compacted.
  #
  # @param [none]
  # @return [Array]  has ("name", "address1", "address2"(unless nil), "city state zip") or nil
  def order_billing_address_lines
    order.bill_address.try(:full_address_array)
  end

  # date the invoice was created (not the date it was paid)
  #
  # @param [Optional Symbol] date format to be returned
  # @return [String] formated date
  def invoice_date(format = :us_date)
    I18n.localize(created_at, :format => format)
  end

  # invoice number
  #
  # @param [none]
  # @return [String] invoice number calculated based off the id and preset values
  def number
    (NUMBER_SEED + id).to_s(CHARACTERS_SEED)
  end

  # invoice id calculated from the id of the number
  #
  # @param [none]
  # @return [Integer] invoice id calculated based off the id and preset values
  def self.id_from_number(num)
    num.to_i(CHARACTERS_SEED) - NUMBER_SEED
  end

  # find invoice based off the invoice's number
  #
  # @param [String] invoice Number
  # @return [Invoice] invoice
  def self.find_by_number(num)
    find(id_from_number(num))##  now we can search by id which should be much faster
  end

  # make an invoice object (not saved)
  #
  # @param [Integer] order id
  # @param [Decimal] amount in dollars
  # @return [Invoice] invoice object
  def Invoice.generate(order_id, charge_amount, credited_amount = 0.0)
    Invoice.new(:order_id => order_id, :amount => charge_amount, :invoice_type => PURCHASE, :credited_amount => credited_amount)
  end

  def self.process_rma(return_amount, order)
    transaction do
      this_invoice = Invoice.new(:order => order, :amount => return_amount, :invoice_type => RMA)
      this_invoice.save
      this_invoice.payment_rma!
      this_invoice
    end
  end

  # call to find the confirmation_id sent by the payment processor.
  #
  # @param [none]
  # @return [String] id the payment processor sends you after authorization.
  def authorization_reference
    if authorization = payments.order('id ASC').find_by(action: 'authorization', success: true )
      authorization.confirmation_id #reference
    end
  end

  # call to find out if the transaction has succeeded.
  #
  # @param [none]
  # @return [Boolean] returns true if the invoice is paid or has been authorized for payment
  def succeeded?
    authorized? || paid?
  end

  # call to find out the amount of the invoice in cents
  #
  # @param [none]
  # @return [Integer] amount of the invoice in cents
  def integer_amount
    times_x_amount = amount.integer? ? 1 : 100
    (amount * times_x_amount).to_i
  end

  def authorize_payment(credit_card, options = {})
    options[:number] ||= unique_order_number
    transaction do
      authorization = Payment.authorize(integer_amount, credit_card, options)
      payments.push(authorization)
      if authorization.success?
        payment_authorized!        
      else
        transaction_declined!
      end
      authorization
    end
  end

  def capture_payment(options = {})
    transaction do
      capture = Payment.capture(integer_amount, authorization_reference, options)
      payments.push(capture)
      if capture.success?
        payment_captured!        
      else
        transaction_declined!
      end
      capture
    end
  end

  def self.with_order_number(order_number)
    where("orders.number = ?", order_number)
  end
  
  private

  def unique_order_number
    "#{Time.now.to_i}-#{rand(1000000)}"
  end
end
