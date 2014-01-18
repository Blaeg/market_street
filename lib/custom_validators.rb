module CustomValidators
  class Emails
    # please refer to : http://stackoverflow.com/questions/703060/valid-email-address-regular-expression
    def self.email_validator
      /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i
    end
  end

  class Numbers
    def self.phone_number_validator
      /(?:\+?|\b)[0-9]{10}\b/
    end
  end

  class Names
    def self.name_validator
      #/([a-zA-Z-’'` ].+)/ \A and \z
      #/^([a-z])+([\\']|[']|[\.]|[\s]|[-]|)+([a-z]|[\.])+$/i
      #/^([a-z]|[\\']|[']|[\.]|[\s]|[-]|)+([a-z]|[\.])+$/i
      /\A([[:alpha:]]|[\\']|[']|[\.]|[\s]|[-]|)+([[:alpha:]]|[\.])+\z/i
    end
  end  
end
