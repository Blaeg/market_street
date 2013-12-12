FactoryGirl.define do
  factory :return_item do
    order_item       { |c| c.association(:order_item) }
    return_condition 'GOOD'
    return_reason    'WRONG_ITEM'
    return_authorization { |c| c.association(:return_authorization) }
    returned false
    updated_by 1
  end
end
