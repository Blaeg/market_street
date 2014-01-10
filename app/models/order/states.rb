require 'active_support/concern'
module Order::States
  extend ActiveSupport::Concern
  included do
    state_machine :initial => 'initial' do
      state 'initial'
      state 'completed'
      state 'paid'
      state 'canceled'

      event :complete do
        transition :to => 'completed', :from => 'initial'
      end

      event :pay do
        transition :to => 'paid', :from => 'completed'
      end

      event :cancel do 
        transition :to => 'canceled', :from => 'completed'
      end

      after_transition :to => 'paid', :do => [:mark_items_paid]
    end

    def mark_items_paid
      order_items.map(&:pay!)
    end
  end
end


