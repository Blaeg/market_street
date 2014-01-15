require 'active_support/concern'
module OrderItem::States
  extend ActiveSupport::Concern

  included do
    state_machine :initial => 'unpaid' do
      event :pay do
        transition :to => 'paid', :from => ['unpaid']
      end

      event :return do
        transition :to => 'returned', :from => ['paid']
      end
      #after_transition :to => 'complete', :do => [:update_inventory]
    end

    def shipped?
      !shipped_at.nil?
    end

    def unshipped?
      shipped_at.nil?
    end
  end
end


