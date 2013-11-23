require 'active_support/concern'
module Order::States
  extend ActiveSupport::Concern
  included do
    state_machine :initial => 'in_progress' do
      state 'in_progress'
      state 'complete'
      state 'paid'
      state 'canceled'

      after_transition :to => 'paid', :do => [:mark_items_paid]

      event :complete do
        transition :to => 'complete', :from => 'in_progress'
      end

      event :pay do
        transition :to => 'paid', :from => ['in_progress', 'complete']
      end
    end

    def mark_items_paid
      order_items.map(&:pay!)
    end
  end
end


