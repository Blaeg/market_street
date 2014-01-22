require 'spec_helper'

describe OfferService do
  context ".order.credit_amount" do    
    xit 'calculate credit_amount' do
      order.stubs(:calculated_at).returns(nil)
      order_item = create(:order_item, :total_amount => 5.52)

      order.stubs(:order_items).returns([order_item, order_item])
      order.stubs(:shipping_amount).returns(100.00)

      # shippping == 100
      # items     == 11.04
      # taxes     == 11.04 * .10 == 1.10
      # credits   == 10.02
      # total     == 112.14 - 10.02 = 102.12
      order.user.store_credit.amount = 10.02
      order.user.store_credit.save

      order.credit_amount.should == 102.12
    end

    xit 'calculate credit_amount' do
      order.stubs(:calculated_at).returns(nil)
      order_item = create(:order_item, :total_amount => 5.52 )
      order.stubs(:order_items).returns([order_item, order_item])
      order.stubs(:shipping_amount).returns(10.00)

      order.user.store_credit.amount = 100.02
      order.user.store_credit.save

      order.credit_amount.should == 0.0
    end
  end

  context ".order.remove_user_store_credits" do
    xit 'remove store_credits.amount' do
      order.stubs(:calculated_at).returns(nil)
      order_item = create(:order_item, :total_amount => 5.52 )
      order.stubs(:order_items).returns([order_item, order_item])
      order.stubs(:shipping_amount).returns(100.00)
      
      order.user.store_credit.amount = 15.52
      order.user.store_credit.save
      order.remove_user_store_credits
      store_credit = StoreCredit.find(order.user.store_credit.id)
      store_credit.amount.should == 0.0
    end

    xit 'calculate credit_amount with a coupon' do
      user = create(:user)
      coupon = create(:coupon, :amount => 15.00, :expires_at => (Time.zone.now + 1.days), :starts_at => (Time.zone.now - 1.days) )
      order = create(:order, :user => user, :coupon => coupon)

      order.stubs(:calculated_at).returns(nil)

      order_item1 = create(:order_item, :price => 20.00, :total_amount => 20.00, :order => order )
      order_item2 = create(:order_item, :price => 20.00, :total_amount => 20.00, :order => order )

      order.stubs(:coupon).returns(coupon)
      order.stubs(:shipping_amount).returns(100.00)

      order.user.store_credit.amount = 10.02
      order.user.store_credit.save
      order.reload
      order.credit_amount.should == 117.48
    end

    xit 'remove store_credits.amount' do
      order.stubs(:calculated_at).returns(nil)
      order_item = create(:order_item, :total_amount => 5.52)
      order.stubs(:order_items).returns([order_item, order_item])
      order.stubs(:shipping_amount).returns(5.00)
      
      order.user.store_credit.amount = 116.05
      order.user.store_credit.save
      store_credit = StoreCredit.find(order.user.store_credit.id)
      store_credit.amount.should == 98.91
    end
  end
end