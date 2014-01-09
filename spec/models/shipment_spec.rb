require 'spec_helper'

describe Shipment, 'instance methods' do
  before(:each) do
    User.any_instance.stubs(:start_store_credits).returns(true)  ## simply speed up tests, no reason to have store_credit object
    @shipment = create(:shipment)
  end

  context '.set_to_shipped' do
    #self.shipped_at = Time.zone.now
    it "marks the shipment as shipped" do
      @shipment.set_to_shipped
      @shipment.shipped_at.should_not be_nil
    end
  end

  context '.ship_inventory' do
    it "subtracts the count on hand and pending to customer for each order_item" do
      @inventory  = create(:inventory, :count_on_hand => 100, :count_pending_to_customer => 50)
      @variant    = create(:variant, :inventory => @inventory)
      @order_item = create(:order_item, :variant => @variant)
      @shipment.order_item = @order_item
      @shipment.ship_inventory
      variant_after_shipment = Variant.find(@variant.id)
      variant_after_shipment.count_on_hand.should == 99
      variant_after_shipment.count_pending_to_customer.should == 49
    end
  end

  context '.mark_order_as_shipped' do
    it 'marks the order shipped' do
      @shipment.order_item.shipped_at = nil
      @shipment.mark_order_as_shipped
      expect(@shipment.order_item.shipped_at).not_to be_nil
    end
  end

  context '.display_shipped_at(format = :us_date)' do
    # shipped_at ? shipped_at.strftime(format) : 'Not Shipped.'
    it 'displays the time it was shipped' do
      # I18n.translate('time.formats.us_date')
      now = Time.zone.now
      @shipment.shipped_at = now
      @shipment.display_shipped_at.should == now.strftime('%m/%d/%Y')
    end

    it 'diplay "Not Shipped"' do
      @shipment.shipped_at = nil
      @shipment.display_shipped_at.should == "Not Shipped."
    end
  end
end

describe Shipment, 'instance method from build' do
  before(:each) do
    User.any_instance.stubs(:start_store_credits).returns(true)  ## simply speed up tests, no reason to have store_credit object
    @user = create(:user)
    @address1 = create(:address, :addressable => @user)
    #@address2 = create(:address, :addressable => @user)
    @order = create(:order, :user => @user)
    @shipment = create(:shipment, :address => @address1)
  end

  context '.shipping_addresses' do
    # order.user.shipping_addresses
    it 'returns all the shipping addresses for the user' do
      shipment = Shipment.find(@shipment.id)
      expect(shipment.address.id).not_to be_nil      
    end
  end
end

describe Shipment, 'instance method from build' do
  before(:each) do
    User.any_instance.stubs(:start_store_credits).returns(true)  ## simply speed up tests, no reason to have store_credit object
    @shipment = build(:shipment)
  end

  context '.set_number, save_shipment_number and set_shipment_number' do
    it "set_number after saving" do
      @shipment.number.should be_nil
      @shipment.save
      @shipment.number.should_not be_nil
      @shipment.number.should  == (Shipment::NUMBER_SEED + @shipment.id).to_s(Shipment::CHARACTERS_SEED)
    end
  end
end

describe Shipment, '#create_shipments_with_items(order)' do
  let(:order) { create(:order) }
  before(:each) do
    User.any_instance.stubs(:start_store_credits).returns(true)    
  end

  it 'create shipments with the items in the order'do
    order.order_items << create(:order_item, :order => order)
    order.order_items << create(:order_item, :order => order)
    shipment = Shipment.create_shipments_with_items(order)
    expect(order.order_items).to have(2).items
    expect(order.reload.shipments_count).to eq 2
  end
end

describe Shipment, 'Class Methods' do
  before(:each) do
    User.any_instance.stubs(:start_store_credits).returns(true)  ## simply speed up tests, no reason to have store_credit object
  end

  describe Shipment, "#id_from_number(num)" do
    let(:shipment) { create(:shipment) }
    it 'returns shipment id' do
      expect(shipment.id).to eq Shipment.id_from_number(shipment.number)
    end
  end

  describe Shipment, "#find_by_number(num)" do
    let(:shipment) { create(:shipment) }
    it 'find the shipment by number' do
      expect(shipment.id).to eq Shipment.find_by_number(shipment.number).id      
    end
  end
end
