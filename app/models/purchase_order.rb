# == Schema Information
#
# Table name: purchase_orders
#
#  id                   :integer(4)      not null, primary key
#  supplier_id          :integer(4)      not null
#  invoice_number       :string(255)
#  tracking_number      :string(255)
#  notes                :string(255)
#  state                :string(255)
#  ordered_at           :datetime        not null
#  estimated_arrival_on :date
#  created_at           :datetime
#  updated_at           :datetime
#  total_cost           :decimal(8, 2)   default(0.0), not null
#

class PurchaseOrder < ActiveRecord::Base
  require_dependency 'purchase_order/states'
  include PurchaseOrder::States

  include TransactionAccountable

  belongs_to :supplier

  has_many  :purchase_order_variants
  has_many  :variants, :through => :purchase_order_variants

  has_many  :transaction_ledgers, :as => :accountable

  validates :invoice_number,  :presence => true, :length => { :maximum => 200 }
  validates :ordered_at,      :presence => true
  validates :total_cost,      :presence => true
  #validates :is_received,     :presence => true

  accepts_nested_attributes_for :purchase_order_variants,
                                :reject_if      => lambda { |attributes| attributes['cost'].blank? && attributes['quantity'].blank? },
                                :allow_destroy  => true

  

  # in the admin form this is the method called when the form is submitted, The method sets
  # the PO to complete, pays for the order in the accounting peice and adds the inventory to stock
  #
  # @param [String] value for set_keywords in a products form
  # @return [none]
  def receive_po=(answer)

    if (answer == 'true' || answer == '1') && (state != RECEIVED)
      self.complete!
    end
  end

  # in the admin form this is the method called when the form is created, The method
  # determines if the order has already been received
  #
  # @return [Boolean]
  def receive_po
    (state == RECEIVED)
  end

  def receive_variants
    po_variants = PurchaseOrderVariant.where(:purchase_order_id => self.id)
    po_variants.each do |po_variant|
      po_variant.with_lock do
        po_variant.receive! unless po_variant.is_received?
      end
    end
  end

  def display_received
    receive_po ? 'Yes' : 'No'
  end

  def display_estimated_arrival_on
    estimated_arrival_on? ? estimated_arrival_on.to_s(:format => :us_date) : ""
  end

  def display_tracking_number
    tracking_number? ? tracking_number : 'N/A'
  end

  def supplier_name
    supplier.name rescue 'N/A'
  end  
end
