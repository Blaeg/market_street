module Presentation
  module UserPresenter
    extend ActiveSupport::Concern

    # gives the user's first and last name if available, otherwise returns the users email
    #
    # @param [none]
    # @return [ String ]
    def name
      (first_name? && last_name?) ? [first_name.capitalize, last_name.capitalize ].join(" ") : email
    end

    # name and email string for the user
    # ex. '"John Wayne" "jwayne@badboy.com"'
    #
    # @param  [ none ]
    # @return [ String ]
    def email_address_with_name
      "\"#{name}\" <#{email}>"
    end
  end
end
