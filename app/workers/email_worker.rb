module EmailWorker
  class SendSignUpNotification
    include Sidekiq::Worker
    def perform(user_id)
      UserMailer.signup_notification(user_id).deliver
    end
  end

  class SendPasswordResetInstructions
    include Sidekiq::Worker
    sidekiq_options queue: "high"
    def perform(user_id)
      UserMailer.password_reset_instructions(user_id).deliver
    end
  end

  class SendOrderConfirmation
    include Sidekiq::Worker
    sidekiq_options queue: "high"
    def perform(order_id, invoice_id)
      UserMailer.order_confirmation(order_id, invoice_id).deliver
    end
  end
end