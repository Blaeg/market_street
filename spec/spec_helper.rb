# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require "authlogic/test_case"
require "email_spec"
require "mocha/setup"
#require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
# Requires supporting files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
#Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

include Hadean::TruncateHelper
include Hadean::TestHelpers
include Authlogic::TestCase
include ActiveMerchant::Billing

Rails.logger.level = 4
Settings.require_state_in_address = true

#include ActionDispatch::TestProcess

RSpec.configure do |config|
  config.mock_with :mocha
  config.include FactoryGirl::Syntax::Methods
  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true
  config.use_transactional_fixtures = false

  #config.order = "random"

  config.before(:suite) { trunctate_unseeded }

  # config.before(:suite) do 
  #   DatabaseCleaner.strategy = :transaction
  #   DatabaseCleaner.clean_with(:truncation)    
  # end

  config.before(:all) do
    Country::create_usa    
    FactoryGirl.create(:state)

    Account::create_all
    AddressType::create_all
    DealType::create_all
    PhoneType::create_all
    ReferralType::create_all
    ReturnCondition::create_all
    ReturnReason::create_all
    Role::create_all
    ShippingZone::create_all
    ShippingRateType::create_all 
    TransactionAccount::create_all
  end

  config.before(:each) do
    User.any_instance.stubs(:create_cim_profile).returns(true)
    User.any_instance.stubs(:update_cim_profile).returns(true)
    User.any_instance.stubs(:delete_cim_profile).returns(true)
    PaymentProfile.any_instance.stubs(:create_payment_profile).returns(true)
    PaymentProfile.any_instance.stubs(:update_payment_profile).returns(true)
    PaymentProfile.any_instance.stubs(:delete_payment_profile).returns(true)
    if defined?(Sunspot)
      ::Sunspot.session = ::Sunspot::Rails::StubSessionProxy.new(::Sunspot.session)
    end
    DatabaseCleaner.start
  end

  config.after(:each) do
    if defined?(Sunspot)
      ::Sunspot.session = ::Sunspot.session.original_session
    end
    DatabaseCleaner.clean
  end

end

def with_solr
  Product.configuration[:if] = 'true'
  yield
  Product.configuration[:if] = false
end

  def credit_card_hash(options = {})
    { :number     => '1',
      :first_name => 'Johnny',
      :last_name  => 'Dee',
      :month      => '8',
      :year       => "#{ Time.now.year + 1 }",
      :verification_value => '323',
      :brand       => 'visa'
    }.update(options)
  end

  def credit_card(options = {})
    ActiveMerchant::Billing::CreditCard.new( credit_card_hash(options) )
  end

  # -------------Payment profile and payment could use this
  def example_credit_card_params( params = {})
    default = {
      :first_name         => 'First Name',
      :last_name          => 'Last Name',
      :brand               => 'visa',
      :number             => '4111111111111111',
      :month              => '10',
      :year               => '2012',
      :verification_value => '999'
    }.merge( params )

    specific = case gateway_name #SubscriptionConfig.gateway_name
      when 'authorize_net_cim'
        {
          :brand               => 'visa',
          :number             => '4007000000027',
        }
        # 370000000000002 American Express Test Card
        # 6011000000000012 Discover Test Card
        # 4007000000027 Visa Test Card
        # 4012888818888 second Visa Test Card
        # 3088000000000017 JCB
        # 38000000000006 Diners Club/ Carte Blanche

      when 'bogus'
        {
          :brand               => 'bogus',
          :number             => '1',
        }

      else
        {}
      end

    default.merge(specific).merge(params)
  end

  def successful_unstore_response
    'transaction_id=d79410c91b4b31ba99f5a90558565df9&error_code=000&auth_response_text=Stored Card Data Deleted'
  end
