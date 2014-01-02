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
      shipment_id?
    end

    def unshipped?
      !shipped?
    end
  end
end


