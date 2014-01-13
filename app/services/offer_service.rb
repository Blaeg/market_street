class OfferService
  attr_accessor :coupon_code, :coupon, :cart

  def initialize(cart, coupon_code)
    @coupon_code = coupon_code
    @coupon = Coupon.find_by_code(coupon_code)
    @cart = cart
  end  

  def validate
    true
  end

  def calculate_discount

  end
end