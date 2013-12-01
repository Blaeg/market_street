require 'spec_helper'

describe EmailWorker::SendSignUpNotification do
  let(:user) { create(:user) }
  it 'sends signup email' do
    # expect(UserMailer).to receive(:signup_notification).
    #   with(user.id).
    #   and_return( double("Mailer", :deliver => true) )
    mock = mock()
    UserMailer.expects(:signup_notification).once.returns(mock)
    mock.stubs(:deliver)
    mock.expects(:deliver).once
    EmailWorker::SendSignUpNotification.new.perform(user.id)
  end
end

describe EmailWorker::SendPasswordResetInstructions do
  let(:user) { create(:user) }
  it 'sends password reset email' do
    mock = mock()
    UserMailer.expects(:password_reset_instructions).once.returns(mock)
    mock.stubs(:deliver)
    mock.expects(:deliver).once
    EmailWorker::SendPasswordResetInstructions.new.perform(user.id)
  end
end

describe EmailWorker::SendOrderConfirmation do
  let(:invoice) { create(:invoice) }
  it 'sends order confirmation email' do
    mock = mock()
    UserMailer.expects(:order_confirmation).once.returns(mock)
    mock.stubs(:deliver)
    mock.expects(:deliver).once
    EmailWorker::SendOrderConfirmation.new.perform(invoice.order.id, invoice.id)
  end
end