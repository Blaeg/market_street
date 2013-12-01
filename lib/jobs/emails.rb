module Jobs
  class SendOrderConfirmation
    @queue = :order_confirmation_emails
    def self.perform(order_id, invoice_id)
      UserMailer.order_confirmation(order_id, invoice_id).deliver
    end
  end

  class SendPasswordResetInstructions
    @queue = :password_reset_emails
    def self.perform(user_id)
      UserMailer.password_reset_instructions(user_id).deliver
    end
  end

  class SendSignUpNotification
    @queue = :signup_notification_emails
    def self.perform(user_id)
      UserMailer.signup_notification(user_id).deliver
    end
  end
end