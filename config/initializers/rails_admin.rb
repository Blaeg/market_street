# RailsAdmin config file. Generated on December 14, 2013 02:09
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|


  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Market Street', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, 'User'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'User'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  # config.excluded_models = ['Account', 'Address', 'Cart', 'CartItem', 'Comment', 'Country', 'Coupon', 'Coupons::CouponFirstPurchasePercent', 'Coupons::CouponFirstPurchaseValue', 'Coupons::CouponPercent', 'Coupons::CouponValue', 'Deal', 'Image', 'ImageGroup', 'Inventory', 'Invoice', 'Order', 'OrderItem', 'Payment', 'PaymentProfile', 'Phone', 'Product', 'ProductProperty', 'ProductType', 'Property', 'Prototype', 'PrototypeProperty', 'PurchaseOrder', 'PurchaseOrderVariant', 'Referral', 'ReferralBonus', 'ReferralProgram', 'ReturnAuthorization', 'ReturnItem', 'Role', 'Sale', 'Shipment', 'ShippingMethod', 'ShippingRate', 'ShippingZone', 'State', 'StoreCredit', 'Supplier', 'TaxRate', 'Transaction', 'TransactionAccount', 'TransactionLedger', 'Transactions::CreditCardCancel', 'Transactions::CreditCardCapture', 'Transactions::CreditCardPayment', 'Transactions::CreditCardReceivePayment', 'Transactions::ReceivePurchaseOrder', 'Transactions::RefundInventory', 'Transactions::ReturnMerchandiseComplete', 'User', 'UserRole', 'Variant', 'VariantProperty', 'VariantSupplier', 'WishItem']

  # Include specific models (exclude the others):
  # config.included_models = ['Account', 'Address', 'Cart', 'CartItem', 'Comment', 'Country', 'Coupon', 'Coupons::CouponFirstPurchasePercent', 'Coupons::CouponFirstPurchaseValue', 'Coupons::CouponPercent', 'Coupons::CouponValue', 'Deal', 'Image', 'ImageGroup', 'Inventory', 'Invoice', 'Order', 'OrderItem', 'Payment', 'PaymentProfile', 'Phone', 'Product', 'ProductProperty', 'ProductType', 'Property', 'Prototype', 'PrototypeProperty', 'PurchaseOrder', 'PurchaseOrderVariant', 'Referral', 'ReferralBonus', 'ReferralProgram', 'ReturnAuthorization', 'ReturnItem', 'Role', 'Sale', 'Shipment', 'ShippingMethod', 'ShippingRate', 'ShippingZone', 'State', 'StoreCredit', 'Supplier', 'TaxRate', 'Transaction', 'TransactionAccount', 'TransactionLedger', 'Transactions::CreditCardCancel', 'Transactions::CreditCardCapture', 'Transactions::CreditCardPayment', 'Transactions::CreditCardReceivePayment', 'Transactions::ReceivePurchaseOrder', 'Transactions::RefundInventory', 'Transactions::ReturnMerchandiseComplete', 'User', 'UserRole', 'Variant', 'VariantProperty', 'VariantSupplier', 'WishItem']

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]


  ################  Model configuration  ################

  # Each model configuration can alternatively:
  #   - stay here in a `config.model 'ModelName' do ... end` block
  #   - go in the model definition file in a `rails_admin do ... end` block

  # This is your choice to make:
  #   - This initializer is loaded once at startup (modifications will show up when restarting the application) but all RailsAdmin configuration would stay in one place.
  #   - Models are reloaded at each request in development mode (when modified), which may smooth your RailsAdmin development workflow.


  # Now you probably need to tour the wiki a bit: https://github.com/sferik/rails_admin/wiki
  # Anyway, here is how RailsAdmin saw your application's models when you ran the initializer:



  ###  Account  ###

  # config.model 'Account' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your account.rb model definition

  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :account_type, :string 
  #     configure :monthly_charge, :decimal 
  #     configure :active, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end
  
  ###  Address  ###

  # config.model 'Address' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your address.rb model definition

  #   # Found associations:

  #     configure :addressable, :polymorphic_association 
  #     configure :state, :belongs_to_association 
  #     configure :country, :belongs_to_association 
  #     configure :phones, :has_many_association 
  #     configure :shipments, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :first_name, :string 
  #     configure :last_name, :string 
  #     configure :addressable_type, :string         # Hidden 
  #     configure :addressable_id, :integer         # Hidden 
  #     configure :address1, :string 
  #     configure :address2, :string 
  #     configure :city, :string 
  #     configure :state_id, :integer         # Hidden 
  #     configure :state_name, :string 
  #     configure :zip_code, :string 
  #     configure :phone_id, :integer 
  #     configure :alternative_phone, :string 
  #     configure :default, :boolean 
  #     configure :bill_default, :boolean 
  #     configure :active, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :country_code, :integer         # Hidden 
  #     configure :address_type, :string 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end

  ###  Cart  ###

  # config.model 'Cart' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your cart.rb model definition

  #   # Found associations:

  #     configure :user, :belongs_to_association 
  #     configure :cart_items, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  CartItem  ###

  # config.model 'CartItem' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your cart_item.rb model definition

  #   # Found associations:

  #     configure :cart, :belongs_to_association 
  #     configure :variant, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :cart_id, :integer         # Hidden 
  #     configure :variant_id, :integer         # Hidden 
  #     configure :quantity, :integer 
  #     configure :active, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Comment  ###

  # config.model 'Comment' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your comment.rb model definition

  #   # Found associations:

  #     configure :commentable, :polymorphic_association 
  #     configure :author, :belongs_to_association 
  #     configure :user, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :note, :text 
  #     configure :commentable_type, :string         # Hidden 
  #     configure :commentable_id, :integer         # Hidden 
  #     configure :created_by, :integer         # Hidden 
  #     configure :user_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Country  ###

  # config.model 'Country' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your country.rb model definition

  #   # Found associations:

  #     configure :states, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :abbreviation, :string 
  #     configure :active, :boolean 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Coupon  ###

  # config.model 'Coupon' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your coupon.rb model definition

  #   # Found associations:

  #     configure :orders, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :type, :string 
  #     configure :code, :string 
  #     configure :amount, :decimal 
  #     configure :minimum_value, :decimal 
  #     configure :percent, :integer 
  #     configure :description, :text 
  #     configure :combine, :boolean 
  #     configure :starts_at, :datetime 
  #     configure :expires_at, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Coupons::CouponFirstPurchasePercent  ###

  # config.model 'Coupons::CouponFirstPurchasePercent' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your coupons/coupon_first_purchase_percent.rb model definition

  #   # Found associations:

  #     configure :orders, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :type, :string 
  #     configure :code, :string 
  #     configure :amount, :decimal 
  #     configure :minimum_value, :decimal 
  #     configure :percent, :integer 
  #     configure :description, :text 
  #     configure :combine, :boolean 
  #     configure :starts_at, :datetime 
  #     configure :expires_at, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Coupons::CouponFirstPurchaseValue  ###

  # config.model 'Coupons::CouponFirstPurchaseValue' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your coupons/coupon_first_purchase_value.rb model definition

  #   # Found associations:

  #     configure :orders, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :type, :string 
  #     configure :code, :string 
  #     configure :amount, :decimal 
  #     configure :minimum_value, :decimal 
  #     configure :percent, :integer 
  #     configure :description, :text 
  #     configure :combine, :boolean 
  #     configure :starts_at, :datetime 
  #     configure :expires_at, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Coupons::CouponPercent  ###

  # config.model 'Coupons::CouponPercent' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your coupons/coupon_percent.rb model definition

  #   # Found associations:

  #     configure :orders, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :type, :string 
  #     configure :code, :string 
  #     configure :amount, :decimal 
  #     configure :minimum_value, :decimal 
  #     configure :percent, :integer 
  #     configure :description, :text 
  #     configure :combine, :boolean 
  #     configure :starts_at, :datetime 
  #     configure :expires_at, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Coupons::CouponValue  ###

  # config.model 'Coupons::CouponValue' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your coupons/coupon_value.rb model definition

  #   # Found associations:

  #     configure :orders, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :type, :string 
  #     configure :code, :string 
  #     configure :amount, :decimal 
  #     configure :minimum_value, :decimal 
  #     configure :percent, :integer 
  #     configure :description, :text 
  #     configure :combine, :boolean 
  #     configure :starts_at, :datetime 
  #     configure :expires_at, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Deal  ###

  # config.model 'Deal' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your deal.rb model definition

  #   # Found associations:

  #     configure :product_type, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :buy_quantity, :integer 
  #     configure :get_percentage, :integer 
  #     configure :product_type_id, :integer         # Hidden 
  #     configure :get_amount, :integer 
  #     configure :deleted_at, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :deal_type, :string 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Image  ###

  # config.model 'Image' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your image.rb model definition

  #   # Found associations:

  #     configure :imageable, :polymorphic_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :imageable_id, :integer         # Hidden 
  #     configure :imageable_type, :string         # Hidden 
  #     configure :image_height, :integer 
  #     configure :image_width, :integer 
  #     configure :position, :integer 
  #     configure :caption, :string 
  #     configure :photo_file_name, :string         # Hidden 
  #     configure :photo_content_type, :string         # Hidden 
  #     configure :photo_file_size, :integer         # Hidden 
  #     configure :photo_updated_at, :datetime         # Hidden 
  #     configure :photo, :paperclip 
  #     configure :updated_at, :datetime 
  #     configure :created_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Inventory  ###

  # config.model 'Inventory' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your inventory.rb model definition

  #   # Found associations:

  #     configure :variant, :has_one_association 
  
  #   # Found columns:

  #     configure :id, :integer 
  #     configure :count_on_hand, :integer 
  #     configure :count_pending_to_customer, :integer 
  #     configure :count_pending_from_supplier, :integer 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Invoice  ###

  # config.model 'Invoice' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your invoice.rb model definition

  #   # Found associations:

  #     configure :order, :belongs_to_association 
  #     configure :payments, :has_many_association 
  
  #   # Found columns:

  #     configure :id, :integer 
  #     configure :order_id, :integer         # Hidden 
  #     configure :amount, :decimal 
  #     configure :invoice_type, :string 
  #     configure :state, :string 
  #     configure :active, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :credited_amount, :decimal 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Order  ###

  # config.model 'Order' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your order.rb model definition

  #   # Found associations:

  #     configure :user, :belongs_to_association 
  #     configure :bill_address, :belongs_to_association 
  #     configure :ship_address, :belongs_to_association 
  #     configure :coupon, :belongs_to_association 
  #     configure :order_items, :has_many_association 
  #     configure :shipments, :has_many_association 
  #     configure :invoices, :has_many_association 
  #     configure :completed_invoices, :has_many_association 
  #     configure :authorized_invoices, :has_many_association 
  #     configure :paid_invoices, :has_many_association 
  #     configure :canceled_invoices, :has_many_association 
  #     configure :return_authorizations, :has_many_association 
  #     configure :comments, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :number, :string 
  #     configure :ip_address, :string 
  #     configure :email, :string 
  #     configure :state, :string 
  #     configure :user_id, :integer         # Hidden 
  #     configure :bill_address_id, :integer         # Hidden 
  #     configure :ship_address_id, :integer         # Hidden 
  #     configure :coupon_id, :integer         # Hidden 
  #     configure :active, :boolean 
  #     configure :shipped, :boolean 
  #     configure :calculated_at, :datetime 
  #     configure :completed_at, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :credited_amount, :decimal 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  OrderItem  ###

  # config.model 'OrderItem' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your order_item.rb model definition

  #   # Found associations:

  #     configure :order, :belongs_to_association 
  #     configure :variant, :belongs_to_association 
  #     configure :tax_rate, :belongs_to_association 
  #     configure :shipping_rate, :belongs_to_association 
  #     configure :shipment, :belongs_to_association 
  #     configure :return_items, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :price, :decimal 
  #     configure :total, :decimal 
  #     configure :order_id, :integer         # Hidden 
  #     configure :variant_id, :integer         # Hidden 
  #     configure :state, :string 
  #     configure :tax_rate_id, :integer         # Hidden 
  #     configure :shipping_rate_id, :integer         # Hidden 
  #     configure :shipment_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :quantity, :integer 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Payment  ###

  # config.model 'Payment' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your payment.rb model definition

  #   # Found associations:

  #     configure :invoice, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :invoice_id, :integer         # Hidden 
  #     configure :confirmation_id, :string 
  #     configure :amount, :integer 
  #     configure :error, :string 
  #     configure :error_code, :string 
  #     configure :message, :string 
  #     configure :action, :string 
  #     configure :params, :serialized 
  #     configure :success, :boolean 
  #     configure :test, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  PaymentProfile  ###

  # config.model 'PaymentProfile' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your payment_profile.rb model definition

  #   # Found associations:

  #     configure :user, :belongs_to_association 
  #     configure :address, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :address_id, :integer         # Hidden 
  #     configure :payment_cim_id, :string 
  #     configure :default, :boolean 
  #     configure :active, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :last_digits, :string 
  #     configure :month, :string 
  #     configure :year, :string 
  #     configure :cc_type, :string 
  #     configure :first_name, :string 
  #     configure :last_name, :string 
  #     configure :card_name, :string 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Phone  ###

  # config.model 'Phone' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your phone.rb model definition

  #   # Found associations:

  #     configure :phoneable, :polymorphic_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :number, :string 
  #     configure :phoneable_type, :string         # Hidden 
  #     configure :phoneable_id, :integer         # Hidden 
  #     configure :primary, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :phone_type, :string 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Product  ###

  # config.model 'Product' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your product.rb model definition

  #   # Found associations:

  #     configure :product_type, :belongs_to_association 
  #     configure :prototype, :belongs_to_association 
  #     configure :shipping_method, :belongs_to_association 
  #     configure :product_properties, :has_many_association 
  #     configure :properties, :has_many_association 
  #     configure :variants, :has_many_association 
  #     configure :images, :has_many_association 
  #     configure :active_variants, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :description, :text 
  #     configure :product_keywords, :serialized 
  #     configure :product_type_id, :integer         # Hidden 
  #     configure :prototype_id, :integer         # Hidden 
  #     configure :permalink, :string 
  #     configure :available_at, :datetime 
  #     configure :deleted_at, :datetime 
  #     configure :meta_keywords, :string 
  #     configure :meta_description, :string 
  #     configure :featured, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :description_markup, :text 
  #     configure :shipping_method_id, :integer         # Hidden 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  ProductProperty  ###

  # config.model 'ProductProperty' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your product_property.rb model definition

  #   # Found associations:

  #     configure :product, :belongs_to_association 
  #     configure :property, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :product_id, :integer         # Hidden 
  #     configure :property_id, :integer         # Hidden 
  #     configure :position, :integer 
  #     configure :description, :string 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  ProductType  ###

  # config.model 'ProductType' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your product_type.rb model definition

  #   # Found associations:

  #     configure :parent, :belongs_to_association 
  #     configure :children, :has_many_association 
  #     configure :products, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :parent_id, :integer         # Hidden 
  #     configure :active, :boolean 
  #     configure :rgt, :integer 
  #     configure :lft, :integer 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Property  ###

  # config.model 'Property' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your property.rb model definition

  #   # Found associations:

  #     configure :prototype_properties, :has_many_association 
  #     configure :prototypes, :has_many_association 
  #     configure :product_properties, :has_many_association 
  #     configure :products, :has_many_association 
  #     configure :variant_properties, :has_many_association 
  #     configure :variants, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :identifing_name, :string 
  #     configure :display_name, :string 
  #     configure :active, :boolean 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Prototype  ###

  # config.model 'Prototype' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your prototype.rb model definition

  #   # Found associations:

  #     configure :products, :has_many_association 
  #     configure :prototype_properties, :has_many_association 
  #     configure :properties, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :active, :boolean 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  PrototypeProperty  ###

  # config.model 'PrototypeProperty' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your prototype_property.rb model definition

  #   # Found associations:

  #     configure :prototype, :belongs_to_association 
  #     configure :property, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :prototype_id, :integer         # Hidden 
  #     configure :property_id, :integer         # Hidden 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  PurchaseOrder  ###

  # config.model 'PurchaseOrder' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your purchase_order.rb model definition

  #   # Found associations:

  #     configure :supplier, :belongs_to_association 
  #     configure :purchase_order_variants, :has_many_association 
  #     configure :variants, :has_many_association 
  #     configure :transaction_ledgers, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :supplier_id, :integer         # Hidden 
  #     configure :invoice_number, :string 
  #     configure :tracking_number, :string 
  #     configure :notes, :string 
  #     configure :state, :string 
  #     configure :ordered_at, :datetime 
  #     configure :estimated_arrival_on, :date 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :total_cost, :decimal 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  PurchaseOrderVariant  ###

  # config.model 'PurchaseOrderVariant' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your purchase_order_variant.rb model definition

  #   # Found associations:

  #     configure :purchase_order, :belongs_to_association 
  #     configure :variant, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :purchase_order_id, :integer         # Hidden 
  #     configure :variant_id, :integer         # Hidden 
  #     configure :quantity, :integer 
  #     configure :cost, :decimal 
  #     configure :is_received, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Referral  ###

  # config.model 'Referral' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your referral.rb model definition

  #   # Found associations:

  #     configure :referral_program, :belongs_to_association 
  #     configure :referral_user, :belongs_to_association 
  #     configure :referring_user, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :applied, :boolean 
  #     configure :clicked_at, :datetime 
  #     configure :email, :string 
  #     configure :name, :string 
  #     configure :purchased_at, :datetime 
  #     configure :referral_program_id, :integer         # Hidden 
  #     configure :referral_user_id, :integer         # Hidden 
  #     configure :referring_user_id, :integer         # Hidden 
  #     configure :registered_at, :datetime 
  #     configure :sent_at, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  ReferralBonus  ###

  # config.model 'ReferralBonus' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your referral_bonus.rb model definition

  #   # Found associations:

  #     configure :referral_programs, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :amount, :integer 
  #     configure :name, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  ReferralProgram  ###

  # config.model 'ReferralProgram' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your referral_program.rb model definition

  #   # Found associations:

  #     configure :referral_bonus, :belongs_to_association 
  #     configure :referrals, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :active, :boolean 
  #     configure :description, :text 
  #     configure :name, :string 
  #     configure :referral_bonus_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  ReturnAuthorization  ###

  # config.model 'ReturnAuthorization' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your return_authorization.rb model definition

  #   # Found associations:

  #     configure :order, :belongs_to_association 
  #     configure :user, :belongs_to_association 
  #     configure :author, :belongs_to_association 
  #     configure :return_items, :has_many_association 
  #     configure :comments, :has_many_association 
  #     configure :transaction_ledgers, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :number, :string 
  #     configure :amount, :decimal 
  #     configure :restocking_fee, :decimal 
  #     configure :order_id, :integer         # Hidden 
  #     configure :user_id, :integer         # Hidden 
  #     configure :state, :string 
  #     configure :created_by, :integer         # Hidden 
  #     configure :active, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  ReturnItem  ###

  # config.model 'ReturnItem' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your return_item.rb model definition

  #   # Found associations:

  #     configure :return_authorization, :belongs_to_association 
  #     configure :order_item, :belongs_to_association 
  #     configure :last_author, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :return_authorization_id, :integer         # Hidden 
  #     configure :order_item_id, :integer         # Hidden 
  #     configure :returned, :boolean 
  #     configure :updated_by, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :return_condition, :string 
  #     configure :return_reason, :string 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Role  ###

  # config.model 'Role' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your role.rb model definition

  #   # Found associations:

  #     configure :user_roles, :has_many_association 
  #     configure :users, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :string 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Sale  ###

  # config.model 'Sale' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your sale.rb model definition

  #   # Found associations:

  #     configure :product, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :product_id, :integer         # Hidden 
  #     configure :percent_off, :decimal 
  #     configure :starts_at, :datetime 
  #     configure :ends_at, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Shipment  ###

  # config.model 'Shipment' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your shipment.rb model definition

  #   # Found associations:

  #     configure :order, :belongs_to_association 
  #     configure :shipping_method, :belongs_to_association 
  #     configure :address, :belongs_to_association 
  #     configure :order_items, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :order_id, :integer         # Hidden 
  #     configure :shipping_method_id, :integer         # Hidden 
  #     configure :address_id, :integer         # Hidden 
  #     configure :tracking, :string 
  #     configure :number, :string 
  #     configure :state, :string 
  #     configure :shipped_at, :datetime 
  #     configure :active, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  ShippingMethod  ###

  # config.model 'ShippingMethod' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your shipping_method.rb model definition

  #   # Found associations:

  #     configure :shipping_rates, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  ShippingRate  ###

  # config.model 'ShippingRate' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your shipping_rate.rb model definition

  #   # Found associations:

  #     configure :shipping_method, :belongs_to_association 
  #     configure :products, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :shipping_method_id, :integer         # Hidden 
  #     configure :rate, :decimal 
  #     configure :minimum_charge, :decimal 
  #     configure :position, :integer 
  #     configure :active, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :shipping_rate_type, :string 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  ShippingZone  ###

  # config.model 'ShippingZone' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your shipping_zone.rb model definition

  #   # Found associations:

  #     configure :states, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :string 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  State  ###

  # config.model 'State' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your state.rb model definition

  #   # Found associations:

  #     configure :country, :belongs_to_association 
  #     configure :shipping_zone, :belongs_to_association 
  #     configure :addresses, :has_many_association 
  #     configure :tax_rates, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :abbreviation, :string 
  #     configure :described_as, :string 
  #     configure :country_code, :integer         # Hidden 
  #     configure :shipping_zone_id, :integer         # Hidden 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  StoreCredit  ###

  # config.model 'StoreCredit' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your store_credit.rb model definition

  #   # Found associations:

  #     configure :user, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :amount, :decimal 
  #     configure :user_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Supplier  ###

  # config.model 'Supplier' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your supplier.rb model definition

  #   # Found associations:

  #     configure :variant_suppliers, :has_many_association 
  #     configure :variants, :has_many_association 
  #     configure :phones, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :email, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  TaxRate  ###

  # config.model 'TaxRate' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your tax_rate.rb model definition

  #   # Found associations:

  #     configure :state, :belongs_to_association 
  #     configure :country, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :percentage, :decimal 
  #     configure :state_id, :integer         # Hidden 
  #     configure :country_code, :integer         # Hidden 
  #     configure :start_date, :date 
  #     configure :end_date, :date 
  #     configure :active, :boolean 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Transaction  ###

  # config.model 'Transaction' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your transaction.rb model definition

  #   # Found associations:

  #     configure :transaction_ledgers, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :type, :string 
  #     configure :batch_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  TransactionAccount  ###

  # config.model 'TransactionAccount' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your transaction_account.rb model definition

  #   # Found associations:

  #     configure :transaction_ledgers, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  TransactionLedger  ###

  # config.model 'TransactionLedger' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your transaction_ledger.rb model definition

  #   # Found associations:

  #     configure :accountable, :polymorphic_association 
  #     configure :transaction, :belongs_to_association 
  #     configure :transaction_account, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :accountable_type, :string         # Hidden 
  #     configure :accountable_id, :integer         # Hidden 
  #     configure :transaction_id, :integer         # Hidden 
  #     configure :transaction_account_id, :integer         # Hidden 
  #     configure :tax_amount, :decimal 
  #     configure :debit, :decimal 
  #     configure :credit, :decimal 
  #     configure :period, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Transactions::CreditCardCancel  ###

  # config.model 'Transactions::CreditCardCancel' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your transactions/credit_card_cancel.rb model definition

  #   # Found associations:

  #     configure :transaction_ledgers, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :type, :string 
  #     configure :batch_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Transactions::CreditCardCapture  ###

  # config.model 'Transactions::CreditCardCapture' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your transactions/credit_card_capture.rb model definition

  #   # Found associations:

  #     configure :transaction_ledgers, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :type, :string 
  #     configure :batch_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Transactions::CreditCardPayment  ###

  # config.model 'Transactions::CreditCardPayment' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your transactions/credit_card_payment.rb model definition

  #   # Found associations:

  #     configure :transaction_ledgers, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :type, :string 
  #     configure :batch_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Transactions::CreditCardReceivePayment  ###

  # config.model 'Transactions::CreditCardReceivePayment' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your transactions/credit_card_receive_payment.rb model definition

  #   # Found associations:

  #     configure :transaction_ledgers, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :type, :string 
  #     configure :batch_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Transactions::ReceivePurchaseOrder  ###

  # config.model 'Transactions::ReceivePurchaseOrder' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your transactions/receive_purchase_order.rb model definition

  #   # Found associations:

  #     configure :transaction_ledgers, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :type, :string 
  #     configure :batch_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Transactions::RefundInventory  ###

  # config.model 'Transactions::RefundInventory' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your transactions/refund_inventory.rb model definition

  #   # Found associations:

  #     configure :transaction_ledgers, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :type, :string 
  #     configure :batch_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Transactions::ReturnMerchandiseComplete  ###

  # config.model 'Transactions::ReturnMerchandiseComplete' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your transactions/return_catalog_complete.rb model definition

  #   # Found associations:

  #     configure :transaction_ledgers, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :type, :string 
  #     configure :batch_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  User  ###

  # config.model 'User' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your user.rb model definition

  #   # Found associations:

  #     configure :account, :belongs_to_association 
  #     configure :referrals, :has_many_association 
  #     configure :referree, :has_one_association 
  #     configure :store_credit, :has_one_association 
  #     configure :orders, :has_many_association 
  #     configure :comments, :has_many_association 
  #     configure :customer_comments, :has_many_association 
  #     configure :shipments, :has_many_association 
  #     configure :finished_orders, :has_many_association 
  #     configure :completed_orders, :has_many_association 
  #     configure :phones, :has_many_association 
  #     configure :primary_phone, :has_one_association 
  #     configure :addresses, :has_many_association 
  #     configure :default_billing_address, :has_one_association 
  #     configure :billing_addresses, :has_many_association 
  #     configure :default_shipping_address, :has_one_association 
  #     configure :shipping_addresses, :has_many_association 
  #     configure :user_roles, :has_many_association 
  #     configure :roles, :has_many_association 
  #     configure :carts, :has_many_association 
  #     configure :wish_items, :has_many_association 
  #     configure :payment_profiles, :has_many_association 
  #     configure :transaction_ledgers, :has_many_association 
  #     configure :return_authorizations, :has_many_association 
  #     configure :authored_return_authorizations, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :first_name, :string 
  #     configure :last_name, :string 
  #     configure :email, :string 
  #     configure :state, :string 
  #     configure :account_id, :integer         # Hidden 
  #     configure :customer_cim_id, :string 
  #     configure :password_salt, :string 
  #     configure :crypted_password, :string 
  #     configure :perishable_token, :string 
  #     configure :persistence_token, :string 
  #     configure :access_token, :string 
  #     configure :comments_count, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  UserRole  ###

  # config.model 'UserRole' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your user_role.rb model definition

  #   # Found associations:

  #     configure :role, :belongs_to_association 
  #     configure :user, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :role_id, :integer         # Hidden 
  #     configure :user_id, :integer         # Hidden 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Variant  ###

  # config.model 'Variant' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your variant.rb model definition

  #   # Found associations:

  #     configure :product, :belongs_to_association 
  #     configure :inventory, :belongs_to_association 
  #     configure :variant_suppliers, :has_many_association 
  #     configure :suppliers, :has_many_association 
  #     configure :variant_properties, :has_many_association 
  #     configure :properties, :has_many_association 
  #     configure :purchase_order_variants, :has_many_association 
  #     configure :purchase_orders, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :product_id, :integer         # Hidden 
  #     configure :sku, :string 
  #     configure :name, :string 
  #     configure :price, :decimal 
  #     configure :cost, :decimal 
  #     configure :deleted_at, :datetime 
  #     configure :master, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :inventory_id, :integer         # Hidden 
  #     configure :retail, :float 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  VariantProperty  ###

  # config.model 'VariantProperty' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your variant_property.rb model definition

  #   # Found associations:

  #     configure :variant, :belongs_to_association 
  #     configure :property, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :variant_id, :integer         # Hidden 
  #     configure :property_id, :integer         # Hidden 
  #     configure :description, :string 
  #     configure :primary, :boolean 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  VariantSupplier  ###

  # config.model 'VariantSupplier' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your variant_supplier.rb model definition

  #   # Found associations:

  #     configure :variant, :belongs_to_association 
  #     configure :supplier, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :variant_id, :integer         # Hidden 
  #     configure :supplier_id, :integer         # Hidden 
  #     configure :cost, :decimal 
  #     configure :total_quantity_supplied, :integer 
  #     configure :min_quantity, :integer 
  #     configure :max_quantity, :integer 
  #     configure :active, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  WishItem  ###

  # config.model 'WishItem' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your wish_item.rb model definition

  #   # Found associations:

  #     configure :user, :belongs_to_association 
  #     configure :variant, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :variant_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end

end
