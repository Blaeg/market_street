require 'spec_helper'

describe Order, "instance methods" do
  before(:each) do
    @user = create(:user)
    @user.stubs(:name).returns('Freddy Boy')
    @order = create(:order, :user => @user)
  end

  context ".name" do
    it 'returns the users name' do
      @order.name.should == 'Freddy Boy'
    end
  end

  context ".display_completed_at(format = :us_date)" do
    it 'returns the completed date in us format' do
      @order.stubs(:completed_at).returns(Time.zone.parse('2010-03-20 14:00:00'))
      @order.display_completed_at.should == '03/20/2010'
    end

    it 'returns "Not Finished."' do
      @order.stubs(:completed_at).returns(nil)
      @order.display_completed_at.should == "Not Finished."
    end
  end

  context ".first_invoice_amount" do
    it 'returns ""' do
      @order.stubs(:completed_invoices).returns([])
      @order.first_invoice_amount.should == ""
    end
    it 'returns "Not Finished."' do
      @invoice = create(:invoice, :amount => 13.49)
      @order.stubs(:completed_invoices).returns([@invoice])
      @order.first_invoice_amount.should == 13.49
    end
  end

  context ".cancel_unshipped_order(invoice)" do
    let(:invoice) { create(:invoice, :amount => 13.49) }
    let(:order) { create(:completed_order) }
    it 'returns ""' do
      invoice.stubs(:cancel_authorized_payment).returns(true)
      expect(order.cancel_unshipped_order(invoice)).to be_true
      expect(order).to be_canceled
    end
  end

  context ".invoice_status" do
    it 'returns "payment_declined"' do
      @invoice = create(:invoice, :state => 'payment_declined')
      @order.stubs(:invoices).returns([@invoice])
      @order.invoice_status.should == 'payment_declined'
    end
    it 'returns "not processed"' do
      @order.stubs(:invoices).returns([])
      @order.invoice_status.should == 'not processed'
    end
  end

  context ".@order.credit_amount" do

    xit 'calculate credit_amount' do
      @order.stubs(:calculated_at).returns(nil)
      order_item = create(:order_item, :total_amount => 5.52)

      @order.stubs(:order_items).returns([order_item, order_item])
      @order.stubs(:shipping_amount).returns(100.00)

      # shippping == 100
      # items     == 11.04
      # taxes     == 11.04 * .10 == 1.10
      # credits   == 10.02
      # total     == 112.14 - 10.02 = 102.12
      @order.user.store_credit.amount = 10.02
      @order.user.store_credit.save

      @order.credit_amount.should == 102.12
    end

    xit 'calculate credit_amount' do
      @order.stubs(:calculated_at).returns(nil)
      order_item = create(:order_item, :total_amount => 5.52 )
      @order.stubs(:order_items).returns([order_item, order_item])
      @order.stubs(:shipping_amount).returns(10.00)

      @order.user.store_credit.amount = 100.02
      @order.user.store_credit.save

      @order.credit_amount.should == 0.0
    end
  end

  context ".@order.remove_user_store_credits" do
    xit 'remove store_credits.amount' do
      @order.stubs(:calculated_at).returns(nil)
      order_item = create(:order_item, :total_amount => 5.52 )
      @order.stubs(:order_items).returns([order_item, order_item])
      @order.stubs(:shipping_amount).returns(100.00)
      
      @order.user.store_credit.amount = 15.52
      @order.user.store_credit.save
      @order.remove_user_store_credits
      store_credit = StoreCredit.find(@order.user.store_credit.id)
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
      @order.stubs(:calculated_at).returns(nil)
      order_item = create(:order_item, :total_amount => 5.52)
      @order.stubs(:order_items).returns([order_item, order_item])
      @order.stubs(:shipping_amount).returns(5.00)
      
      @order.user.store_credit.amount = 116.05
      @order.user.store_credit.save
      store_credit = StoreCredit.find(@order.user.store_credit.id)
      store_credit.amount.should == 98.91
    end
  end

  context ".capture_invoice(invoice)" do
    let(:invoice) { create(:invoice) }
    let(:order) { create(:completed_order) }
    it 'returns an payment object' do
      payment = order.capture_invoice(invoice)
      expect(payment.is_a?(Payment)).to be_true
      expect(invoice).to be_paid
    end
  end

  #def create_invoice(credit_card, charge_amount, args)
  #  transaction do
  #    create_invoice_transaction(credit_card, charge_amount, args)
  #  end
  #end
  context ".create_invoice(credit_card, charge_amount, args)" do
    it 'returns an create_invoice on success' do
      UserMailer_mock = mock()
      UserMailer_mock.stubs(:deliver)
      UserMailer.stubs(:order_confirmation).returns(UserMailer_mock)
      cc_params = {
        :brand               => 'visa',
        :number             => '1',
        :verification_value => '322',
        :month              => '4',
        :year               => '2010',
        :first_name         => 'Umang',
        :last_name          => 'Chouhan'
      }

      ##  Create fake admin_cart object in memcached
      # create_invoice(credit_card, charge_amount, args)
      credit_card               = ActiveMerchant::Billing::CreditCard.new(cc_params)
      invoice                   = @order.create_invoice(credit_card, 12.45, {})
      invoice.class.to_s.should == 'Invoice'
      invoice.state.should      == 'authorized'
    end

    it 'returns an create_invoice on failure' do
      cc_params = {
        :brand               => 'visa',
        :number             => '2',
        :verification_value => '322',
        :month              => '4',
        :year               => '2010',
        :first_name         => 'Umang',
        :last_name          => 'Chouhan'
      }

      ##  Create fake admin_cart object in memcached
      # create_invoice(credit_card, charge_amount, args)
      credit_card               = ActiveMerchant::Billing::CreditCard.new(cc_params)
      invoice                   = @order.create_invoice(credit_card, 12.45, {})
      invoice.class.to_s.should == 'Invoice'
      invoice.state.should      == 'payment_declined'
    end
  end

  ##  this method is exersized by create_invoice method  TESTED
  context ".create_invoice_transaction(credit_card, charge_amount, args)"

  context ".order_complete!" do
    xit  "set completed_at and update the state" do
      @order.stubs(:update_inventory).returns(true)
      @order.completed_at = nil
      @order.order_complete!
      @order.state.should == 'complete'
      @order.completed_at.should_not == nil
    end
  end

  context ".update_tax_rates" do
    xit 'set the beginning address id after find' do
      order_item = create(:order_item)
      @order.ship_address_id = create(:address).id
      @order.stubs(:order_items).returns([order_item])
    end
  end

  context ".calculate_totals(force = false)" do
    xit 'set the beginning address id after find' do
      order_item = create(:order_item)
      @order.stubs(:order_items).returns([order_item])
      @order.calculated_at = nil
      @order.total_amount = nil
      @order.total_amount.should_not be_nil
    end
  end
#
#shipping_amount

  context ".total amount(force = false)" do
    xit 'calculate the order totals with shipping charges' do
      @order.calculated_at = nil
      @order.order_items << create(:order_item, :total_amount => 5.52, :quantity => 2)    
      @order.shipping_amount = 100.0
      @order.total_amount.should == 112.14
    end
  end

  context ".shipping_amount" do
    it 'returns one shipping rate that all items fall under' do
      order_item = create(:order_item, quantity: 1)
      expect(order_item.order.shipping_amount).to eq(order_item.shipping_amount)
    end    
  end

  context ".add_items(variant, quantity, state_id = nil)" do
    it 'adds a new variant to order items ' do
      variant = create(:variant)
      order_items_size = @order.order_items.size
      @order.add_items(variant, 2)
      @order.order_items.size.should == order_items_size + 1
    end
  end

# context ".remove_items(variant, final_quantity)" do
#   it 'remove variant from order items ' do
#     variant = create(:variant)
#     @order.add_items(variant, 3)
#     expect(@order.reload.order_items.size).to eq(1)
#     @order.remove_items(variant, 0)
#     expect(@order.reload.order_items.size).to eq(0)
#   end
# end

  context ".set_email" do
    #self.email = user.email if user_id
    it 'set the email address if there is a user_id' do
      @order.email = nil
      @order.send(:set_email)
      @order.email.should_not be_nil
      @order.email.should == @order.user.email
    end
    it 'does not set the email address if there is a user_id' do
      @order.email = nil
      @order.user_id = nil
      @order.send(:set_email)
      @order.email.should be_nil
    end
  end

  context ".set_number" do
    it 'set number' do
      @order.send(:set_number)
      @order.number.should == (Order::NUMBER_SEED + @order.id).to_s(Order::CHARACTERS_SEED)
    end

    it 'set number not to be nil' do
      order = build(:order)
      order.send(:set_number)
      order.number.should_not be_nil
    end
  end

  context ".set_order_number" do
    it 'set number ' do
      order = create(:order)
      order.number = nil
      order.send(:set_order_number)
      order.number.should_not be_nil
    end
  end

  context ".save_order_number" do
    it 'set number and save' do
      order = create(:order)
      order.number = nil
      order.send(:save_order_number).should be_true
      order.number.should_not == (Order::NUMBER_SEED + @order.id).to_s(Order::CHARACTERS_SEED)
    end
  end

  context ".update_inventory" do
    #self.order_items.each {|item| item.variant.add_pending_to_customer(1) }
    it 'calls add_pending_to_customer for each variant' do
      variant     = mock()#create(:variant )
      order_item  = create(:order_item)
      order_item.stubs(:variant).returns(variant)
      @order.order_items.push([order_item])
      variant.expects(:add_pending_to_customer).once
      @order.update_inventory
    end
  end

  context ".variant_ids" do
    #order_items.collect{|oi| oi.variant_id }
    it 'returns each  variant_id' do
      variant     = create(:variant )
      order_item  = create(:order_item)
      order_item.stubs(:variant_id).returns(variant.id)
      @order.stubs(:order_items).returns([order_item, order_item])
      @order.variant_ids.should == [variant.id, variant.id]
    end
  end

  context ".has_shipment?" do
    it 'returns false' do
      expect(@order).not_to be_has_shipment
    end
    it 'returns true' do
      order_item = create(:order_item, :order => @order)
      order_item.shipments << create(:shipment)
      expect(@order.reload).to be_has_shipment
    end
  end

  context ".create_shipments_with_order_item_ids(order_item_ids)" do
    xit "returns false if there aren't any ids" do
      @order_item = FactoryGirl.create(:order_item, :order => @order)
      @order.create_shipments_with_order_item_ids([]).should be_false
    end
    
    xit "returns false if the ids cant be shipped" do
      @order_item = FactoryGirl.create(:order_item, :order => @order, :state => 'unpaid')
      @order.create_shipments_with_order_item_ids([@order_item.id]).should be_false
    end
    
    xit "returns true if the ids can be shipped" do
      @order_item = FactoryGirl.build(:order_item, :order => @order)
      @order_item.state = 'paid'
      #@order.create_shipments_with_order_item_ids([@order_item.id]).should be_true
    end
  end

  context '.item_prices' do

    it 'returns an Array of prices' do
      order_item1 = create(:order_item, :order => @order, :price => 2.01)
      order_item2 = create(:order_item, :order => @order, :price => 9.00)
      @order.stubs(:order_items).returns([order_item1, order_item2])
      @order.send(:item_prices).class.should == Array
      @order.send(:item_prices).include?(2.01).should be_true
      @order.send(:item_prices).include?(9.00).should be_true
    end
  end


  context '.coupon_amount' do

    it 'returns 0.0 for no coupon' do
      @order.stubs(:coupon_id).returns(nil)
      @order.coupon_amount.should == 0.0
    end

    it 'returns call coupon.value' do
      coupon  = create(:coupon_value)
      order   = create(:order, :coupon => coupon)
      order.stubs(:coupon_id).returns(2)
      order.coupon.expects(:value).once
      order.coupon_amount
    end
  end

end

describe Order, "Without VAT" do
  let(:order) { create(:order) } 
  
  before(:all) do
    Settings.vat = false
  end

  context ".tax_amount" do
    it 'returns one tax_charges for all order items' do
      order.order_items << create(:order_item, :price => 20.00, :tax_amount => 2.0)
      order.order_items << create(:order_item, :price => 10.00, :tax_amount => 1.0)      
      expect(order.tax_amount).to eq 3.0
    end
  end
end

describe Order, "With VAT" do
  let(:order) { create(:order) }
  
  before(:all) do
    Settings.vat = true
  end

  context ".tax_charges" do
    xit 'returns one tax_charges for all order items' do
      order_item = create(:order_item, :price => 20.00)
      order_item5 = create(:order_item, :price => 10.00)

      order.stubs(:order_items).returns( [order_item, order_item5] )
      order.tax_charges.should == [0.00 , 0.00]
    end
  end

  context ".tax_amount" do
    xit 'returns one tax_charges for all order items' do
      order_item = create(:order_item, :price => 20.00)
      order_item5 = create(:order_item, :price => 10.00)

      order.stubs(:order_items).returns( [order_item, order_item5] )
      order.tax_amount.should == 0.00
    end
  end
end

describe Order, "#find_customer_details" do
  let(:order) { create(:order) }
  it 'returns have invoices and completed_invoices associations' do
    expect(order.completed_invoices).to be_empty
    expect(order.invoices).to be_empty
  end
end

describe Order, "#id_from_number(num)" do
  let(:order) { create(:order) }
  it 'returns the order id' do
    order_id  = Order.id_from_number(order.number)
    expect(order_id).to eq order.id
  end
end

describe Order, "#find_by_number(num)" do
  let(:order) { create(:order) }
  it 'find the order by number' do
    find_order = Order.find_by_number(order.number)
    expect(find_order.id).to eq order.id
  end
end
