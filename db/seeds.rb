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

puts "SEEDING GEO"
Country.create_all
State.create_all

puts "SEEDING USERS"
Role.create_all

@admin = FactoryGirl.create(:super_admin_user, :with_address, 
  first_name: 'Alex', last_name: 'Chen', email: "alex@market.com")

puts  "SEEDING CATALOG"
ProductType.create_all
Prototype.create_all
PhoneType.create_all
DealType.create_all
Account.create_all
TransactionAccount.create_all
ReferralBonus.create_all
ReferralProgram.create_all

puts  "SEEDING SHIPPING"
AddressType.create_all
ShippingMethod.create_all
ShippingRateType.create_all
ShippingZone.create_all
ReturnReason.create_all
ReturnCondition.create_all

ShippingMethod.all.each do |sm|
  FactoryGirl.create(:shipping_rate, shipping_method: sm)      
end

puts  "SEEDING PRODUCTS"
@products = ProductType.all.map do |pt|
  FactoryGirl.create_list(:product, 2, :with_properties, :with_images, :product_type => pt)
end.flatten

puts  "SEEDING VARIANTS"
@products.each do |p|
  p.activate!
  variant = FactoryGirl.create(:variant, product: p)
  
  puts  "SEEDING VARIANT PROPERTIES"
  p.properties.each do |pp|
    variant_property = FactoryGirl.create(:variant_property, :variant => variant, :property => pp)
    variant.variant_properties.push(variant_property)    
  end
end

puts  "SEEDING ORDERS"