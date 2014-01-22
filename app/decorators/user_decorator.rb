class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    [first_name, last_name].compact.map(&:capitalize).join(" ")
  end

  def display_name
    (full_name != "") ? full_name : email
  end

  def email_address_with_name
      "\"#{display_name}\" <#{email}>"
  end

  def merchant_description
    [display_name, default_shipping_address.try(:address_lines)].compact.join(', ')
  end

  def user_profile
    return {:merchant_customer_id => id, :email => email, 
      :description => merchant_description}
  end
end