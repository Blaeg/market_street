Rails.logger.info "Cleaning data"
# truncating all tables
ActiveRecord::Base.establish_connection
ActiveRecord::Base.transaction do
  ActiveRecord::Base.connection.tables.each do |table|
    next if %w{schema_migrations}.include?(table)
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table} CASCADE;")
  end
end

require 'factory_girl_rails'

Rails.logger.info "START SEEDING"
Country.create_all
State.create_all
Role.create_all
AddressType.create_all
PhoneType.create_all
ItemType.create_all
DealType.create_all
Account.create_all
ShippingRateType.create_all
ShippingZone.create_all
TransactionAccount.create_all
ReturnReason.create_all
ReturnCondition.create_all
ReferralBonus.create_all
ReferralProgram.create_all

Rails.logger.info "SEEDING PRODUCTS"
FactoryGirl.create_list(:product, 10)
FactoryGirl.create_list(:variant, 10)

Rails.logger.info "SEEDING ORDERS"