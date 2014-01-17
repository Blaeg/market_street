require 'active_support/concern'
module Invoice::States
  extend ActiveSupport::Concern
  included do
    state_machine :initial => :pending do
      state :pending
      state :authorized
      state :paid
      state :payment_declined
      state :canceled

      event :payment_rma do
        transition :from => :pending, :to   => :refunded
      end
      event :payment_authorized do
        transition :from => :pending, :to   => :authorized
        transition :from => :payment_declined, :to   => :authorized
      end

      event :payment_captured do
        transition :from => :authorized, :to   => :paid
      end
      event :transaction_declined do
        transition :from => :pending, :to   => :payment_declined
        transition :from => :payment_declined, :to   => :payment_declined
        transition :from => :authorized, :to   => :authorized
      end

      event :cancel do
        transition :from => :authorized, :to  => :canceled
      end
    end
  end
end