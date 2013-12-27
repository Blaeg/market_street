ENV["RAILS_ENV"] ||= 'test'
ENV['RAILS_ENV'] = ENV['ENV'] = 'test'

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter "/vendor/"
end

if ENV['CIRCLE_ARTIFACTS'].nil?
  SimpleCov.coverage_dir  'coverage/rspec'
else
  module SimpleCov::Configuration
    def coverage_path
      FileUtils.mkdir_p coverage_dir
      coverage_dir
    end
  end
  SimpleCov.coverage_dir  "#{ENV['CIRCLE_ARTIFACTS']}/simplecov_rspec"
end

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

require "email_spec"
require "mocha/setup"
require "factory_girl_rails"

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

include MarketStreet::TruncateHelper
include MarketStreet::TestHelpers
include ActiveMerchant::Billing

require "authlogic/test_case"
include Authlogic::TestCase

Rails.logger.level = 4
Settings.require_state_in_address = true

RSpec.configure do |config|
  config.mock_with :mocha
  config.include FactoryGirl::Syntax::Methods
  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)

  config.use_transactional_fixtures = false

  config.before(:suite) do
    puts "before suite"
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)

    Role::create_all

    Country::find_or_create_by(id: USA_ID)       
    FactoryGirl.create(:state)

    Property::create_basic
    TransactionAccount.create_all
    ReferralBonus.create_all
    ReferralProgram.create_all

    ShippingMethod.create_all
    ShippingZone.create_all
    
    ShippingMethod.all.each do |sm|
      FactoryGirl.create(:shipping_rate, shipping_method: sm)      
    end
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
