require 'spec_helper'

describe Order, "instance methods" do
  let(:user) { create(:user) }
  let(:order) { create(:order, :user => user) }
  
  context ".name" do
    let(:user) { UserDecorator.decorate(create(:user)) }
    it 'returns the users name' do
      expect(order.name).to eq user.name
    end
  end

  context ".display_completed_at(format = :us_date)" do
    let(:order) { OrderDecorator.decorate(create(:order, :user => user)) }

    it 'returns the completed date in us format' do
      order.stubs(:completed_at).returns(Time.zone.parse('2010-03-20 14:00:00'))
      expect(order.display_completed_at).to eq '03/20/2010'
    end

    it 'returns "Not Finished."' do
      order.stubs(:completed_at).returns(nil)
      expect(order.display_completed_at).to eq "Not Finished."
    end
  end

  context ".first_invoice_amount" do
    it 'returns ""' do
      order.stubs(:completed_invoices).returns([])
      order.first_invoice_amount.should == ""
    end
    it 'returns "Not Finished."' do
      @invoice = create(:invoice, :amount => 13.49)
      order.stubs(:completed_invoices).returns([@invoice])
      order.first_invoice_amount.should == 13.49
    end
  end

  context ".cancel_unshipped_order(invoice)" do
    let(:invoice) { create(:invoice, :amount => 13.49) }
    let(:order) { create(:completed_order) }
    it 'returns ""' do
      expect(order.cancel_unshipped_order(invoice)).to be_true
      expect(order).to be_canceled
    end
  end

  context ".invoice_status" do
    let(:invoice) { create(:invoice, :state => 'payment_declined') }
    
    it 'returns "payment_declined"' do
      order.stubs(:invoices).returns([invoice])
      order.invoice_status.should == 'payment_declined'
    end
    
    it 'returns "not processed"' do
      order.stubs(:invoices).returns([])
      order.invoice_status.should == 'not processed'
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
      invoice                   = order.create_invoice(credit_card, 12.45, {})
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
      invoice                   = order.create_invoice(credit_card, 12.45, {})
      invoice.class.to_s.should == 'Invoice'
      invoice.state.should      == 'payment_declined'
    end
  end

  context ".order_complete!" do
    xit  "set completed_at and update the state" do
      order.stubs(:update_inventory).returns(true)
      order.completed_at = nil
      order.order_complete!
      order.state.should == 'complete'
      order.completed_at.should_not == nil
    end
  end

  context ".set_email" do
    it 'set the email address if there is a user_id' do
      order.email = nil
      order.send(:set_email)
      order.email.should_not be_nil
      order.email.should == order.user.email
    end
    
    it 'does not set the email address if there is a user_id' do
      order.email = nil
      order.user_id = nil
      order.send(:set_email)
      order.email.should be_nil
    end
  end

  context ".set_number" do
    it 'set number' do
      order.send(:set_number)
      order.number.should == (Order::NUMBER_SEED + order.id).to_s(Order::CHARACTERS_SEED)
    end

    it 'set number not to be nil' do
      order = build(:order)
      order.send(:set_number)
      order.number.should_not be_nil
    end
  end

  context ".set_order_number" do
    let(:order) { create(:order) }
    
    it 'set number ' do
      order.number = nil
      order.send(:set_order_number)
      order.number.should_not be_nil
    end
  end

  context ".save_order_number" do
    let(:order) { create(:order) }

    it 'set number and save' do
      order.number = nil
      order.send(:save_order_number).should be_true
      expect(order.number).to eq((Order::NUMBER_SEED + order.id).to_s(Order::CHARACTERS_SEED))
    end
  end

  context ".update_inventory" do
    let(:order_item) { create(:order_item) }
    it 'calls add_pending_to_customer for each variant' do
      variant     = mock()#create(:variant )
      order_item.stubs(:variant).returns(variant)
      order.order_items.push([order_item])
      variant.expects(:add_pending_to_customer).once
      order.update_inventory
    end
  end

  context ".variant_ids" do
    let(:variant) { create(:variant) }
    let(:order_item) { create(:order_item) }
    it 'returns each  variant_id' do
      order_item.stubs(:variant_id).returns(variant.id)
      order.stubs(:order_items).returns([order_item, order_item])
      order.variant_ids.should == [variant.id, variant.id]
    end
  end

  context ".has_shipment?" do
    let(:order_item) { create(:order_item, :order => order) }

    it 'returns false' do
      expect(order).not_to be_has_shipment
    end

    it 'returns true' do
      order_item.shipments << create(:shipment)
      expect(order.reload).to be_has_shipment
    end
  end

  context ".create_shipments_with_order_item_ids(order_item_ids)" do
    xit "returns false if there aren't any ids" do
      order_item = FactoryGirl.create(:order_item, :order => order)
      order.create_shipments_with_order_item_ids([]).should be_false
    end
    
    xit "returns false if the ids cant be shipped" do
      order_item = FactoryGirl.create(:order_item, :order => order, :state => 'unpaid')
      order.create_shipments_with_order_item_ids([order_item.id]).should be_false
    end
    
    xit "returns true if the ids can be shipped" do
      order_item = FactoryGirl.build(:order_item, :order => order)
      order_item.state = 'paid'
    end
  end

  context '.item_prices' do
    let(:order_item1) { create(:order_item, :order => order, :price => 2.01) }
    let(:order_item2) { create(:order_item, :order => order, :price => 9.00) }
    
    it 'returns an Array of prices' do
      order.stubs(:order_items).returns([order_item1, order_item2])
      order.send(:item_prices).class.should == Array
      order.send(:item_prices).include?(2.01).should be_true
      order.send(:item_prices).include?(9.00).should be_true
    end
  end


  context '.coupon_amount' do
    let(:coupon) { create(:coupon_value) } 
    let(:order) { create(:order, :coupon => coupon) } 

    it 'returns 0.0 for no coupon' do
      order.stubs(:coupon_id).returns(nil)
      order.coupon_amount.should == 0.0
    end

    it 'returns call coupon.value' do
      order.stubs(:coupon_id).returns(2)
      order.coupon.expects(:value).once
      order.coupon_amount
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