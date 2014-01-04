require 'active_support/concern'
module User::States
  extend ActiveSupport::Concern
  included do
    state_machine :state, :initial => :active do
      state :inactive
      state :active
      state :canceled

      event :activate do
        transition all => :active, :unless => :active?
      end

      event :cancel do
        transition :from => [:inactive, :active, :canceled], :to => :canceled
      end
    end

    def active?
      !['canceled', 'inactive'].any? {|s| self.state == s }
    end    
  end
end
