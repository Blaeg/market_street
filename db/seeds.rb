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
  first_name: 'Admin', last_name: 'Super', email: "super_admin@market.com")
@admin = FactoryGirl.create(:admin_user, :with_address, 
  first_name: 'Admin', last_name: 'Chen', email: "admin@market.com")
FactoryGirl.create_list(:user, 10)

puts  "SEEDING CATALOG"
ProductType.create_all
Prototype.create_all
Property::create_basic
TransactionAccount.create_all
ReferralBonus.create_all
ReferralProgram.create_all

puts  "SEEDING SHIPPING"
ShippingMethod.create_all
ShippingZone.create_all

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

  2.times do 
    variant = FactoryGirl.create(:variant, product: p)
    
    p.properties.each do |pp|
      variant_property = FactoryGirl.create(:variant_property, :variant => variant, 
                                      :property => pp)
      variant.variant_properties.push(variant_property)    
    end
  end
end

puts  "SEEDING ORDERS"
FactoryGirl.create_list(:order, 5)
puts  "SEEDING SHIPMENTS"
FactoryGirl.create_list(:shipment, 5)
puts  "SEEDING INVOICES"
FactoryGirl.create_list(:invoice, 5)
puts  "SEEDING PURCHASE ORDERS"
FactoryGirl.create_list(:purchase_order, 5)
FactoryGirl.create_list(:supplier, 5)