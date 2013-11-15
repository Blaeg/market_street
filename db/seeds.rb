# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts "START SEEDING"

puts "COUNTRIES"
file_to_load  = Rails.root + 'db/seed/countries.yml'
countries_list   = YAML::load( File.open( file_to_load ) )

countries_list.each_pair do |key,country|
  s = Country.find_by_abbreviation(country['abbreviation'])
  unless s
    c = Country.create(country) unless s
    c.update_attribute(:active, true) if Country::ACTIVE_COUNTRY_IDS.include?(c.id)
  end
end

puts "States"
file_to_load  = Rails.root + 'db/seed/states.yml'
states_list   = YAML::load( File.open( file_to_load ) )


states_list.each_pair do |key,state|
  s = State.find_by_abbreviation_and_country_id(state['attributes']['abbreviation'], state['attributes']['country_id'])
  State.create(state['attributes']) unless s
end

puts "ROLES"
Role::create_all

puts "Address Types"
AddressType.create_all

puts "PHONE TYPES"
PhoneType.create_all

puts "Item Types"
ItemType.create_all

puts "DEAL TYPES"
DealType.create_all

puts "Accounts"
Account.create_all

puts "SHIPPING RATE TYPES"
ShippingRateType.create_all

puts "Shipping Zones"
ShippingZone.create_all

puts "ACCOUNT TYPES"
TransactionAccount.create_all

puts "Return Reasons"
ReturnReason.create_all

puts "Return CONDITIONS"
ReturnCondition.create_all


puts "Referral Bonuses"
ReferralBonus.create_all

puts "Referral PROGRAMS"
ReferralProgram.create_all


