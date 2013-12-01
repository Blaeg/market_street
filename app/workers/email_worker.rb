module Worker    
  class SendOrderConfirmation
    include Sidekiq::Worker
    def self.perform(order_id, invoice_id)
      UserMailer.order_confirmation(order_id, invoice_id).deliver
    end
  end

  class SendPasswordResetInstructions
    include Sidekiq::Worker
    def self.perform(user_id)
      UserMailer.password_reset_instructions(user_id).deliver
    end
  end

  class SendSignUpNotification
    include Sidekiq::Worker
    def self.perform(user_id)
      UserMailer.signup_notification(user_id).deliver
    end
  end
end