FactoryGirl.define do
  factory :state do
    name            'California'
    abbreviation	'CA'
    described_as	'State'
    country_code 		'US'
    shipping_zone 	{ |s| s.association(:shipping_zone)}
  end
end
