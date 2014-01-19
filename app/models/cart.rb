class Cart < ActiveRecord::Base
  require_dependency 'cart/calculator'
  include Cart::Calculator

  belongs_to  :user
  has_many    :cart_items

  belongs_to :ship_address, class_name: 'Address'
  belongs_to :bill_address, class_name: 'Address'

  accepts_nested_attributes_for :cart_items, :ship_address, :bill_address
  scope :active, -> { where("is_active= true") }

  def add_variant(variant_id, quantity = 1)
    cart_item = cart_items.where(variant_id: variant_id).first
    purchaseable_quantity = Variant.find(variant_id).purchaseable_quantity(quantity.to_i)
    return if purchaseable_quantity == 0
    if cart_item.nil?
      cart_items.create(variant_id: variant_id, 
                        quantity: purchaseable_quantity)
    else
      new_quantity = cart_item.quantity + purchaseable_quantity
      cart_item.update_attributes(:quantity => new_quantity)
    end    
  end

  def remove_variant(variant_id)
    cart_items.where(variant_id: variant_id).map(&:inactivate!)
  end

  def active?
    is_active
  end

  def inactivate!
    self.update_attributes(:is_active => false)
    cart_items.map(&:inactivate!)
  end

  def sell_inventory
    cart_items.map(&:sell_inventory)
  end

  def save_user(user)  # u is user object or nil
    self.user = user
    self.save
  end  

  def ready_to_checkout?
    user.present? and !cart_items.empty? and 
    ship_address.present? and bill_address.present?
  end

  def to_order_attributes
    {
      :user      => user,
      :email => user.email,
      :cart_id   => id,
      :tax_rate => tax_rate,
      :tax_amount => tax_amount,
      :credit_amount => credit_amount,
      :shipping_amount => shipping_amount,  
      :total_amount => total_amount,      
      :ship_address_id => ship_address_id,
      :bill_address_id => bill_address_id,      
    }
  end    
end