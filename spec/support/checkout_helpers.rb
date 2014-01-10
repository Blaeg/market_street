module CheckoutHelpers
  def expect_cart_and_order_to_be_equal(cart, order)
    expect(order.user).to eq cart.user
    expect(order.email).to eq cart.user.email

    expect(order.cart_id).to eq cart.id      
    expect(order.ship_address).to eq cart.ship_address
    expect(order.bill_address).to eq cart.bill_address
    
    expect(order.tax_rate).to eq cart.tax_rate
    expect(order.shipping_amount).to eq cart.shipping_amount      
    expect(order.tax_amount).to eq cart.tax_amount      
    expect(order.credit_amount).to eq cart.credit_amount
    expect(order.total_amount).to eq cart.total_amount              
  end  
end
