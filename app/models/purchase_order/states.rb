require 'active_support/concern'
module PurchaseOrder::States
  extend ActiveSupport::Concern
  
  INCOMPLETE  = 'incomplete'
  PENDING     = 'pending'
  RECEIVED    = 'received'
  STATES      = [PENDING, INCOMPLETE, RECEIVED]

  included do
    state_machine :state, :initial => :pending do
      state :pending
      state :incomplete
      state :received

      after_transition :on => :complete, :do => [:pay_for_order, :receive_variants]

      event :complete do |purchase_order|
        transition all => :received
      end

      # mark as complete even though variants might not have been receive & payment was not made
      event :mark_as_complete do
        transition :from => [:pending, :incomplete], :to => :received
      end
    end
  end
end