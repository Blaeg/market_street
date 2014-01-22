class UserDecorator < Draper::Decorator
  delegate_all

  def name
      (first_name? && last_name?) ? [first_name.capitalize, last_name.capitalize ].join(" ") : email
  end

  def email_address_with_name
      "\"#{name}\" <#{email}>"
  end
end


