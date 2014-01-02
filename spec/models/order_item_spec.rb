require 'spec_helper'


describe OrderItem, "instance methods" do

  before(:each) do
    #@order = create(:order)
    @order_item = create(:order_item)#, :order => @order)
  end

  context ".shipped?" do
    it 'returns true if there is a shipment_id' do
      @order_item.shipment_id = 1
      @order_item.shipped?.should be_true
    end

    it 'returns false if there is a shipment_id' do
      @order_item.shipment_id = nil
      @order_item.shipped?.should be_false
    end
  end

  context ".sale_price(at)" do
    it 'returns the price - % discount ' do
      product = FactoryGirl.create(:product)
      variant = FactoryGirl.create(:variant, :product => product)
      new_sale = FactoryGirl.create(:sale,
                                    :product_id   => product.id,
                                    :starts_at    => (Time.zone.now - 1.days),
                                    :ends_at      => (Time.zone.now + 1.days),
                                    :percent_off  => 0.20
                                    )

      sale = Sale.for(product.id, Time.zone.now)
      sale.id.should == new_sale.id

      @order_item.stubs(:price).returns(100.0)
      @order_item.stubs(:variant).returns(variant)
      @order_item.sale_price(Time.zone.now).should == 80.0
    end
  end

  context ".calculate_order" do
    it 'calculate order once after calling method twice' do
      order     = mock()
      @order_item.stubs(:ready_to_calculate?).returns(true)
      @order_item.stubs(:order).returns(order)
      @order_item.order.expects(:calculate_totals).once
      @order_item.calculate_order
      @order_item.calculate_order
    end
  end

  context ".set_order_calculated_at_to_nil" do
    it 'returns the shipping method id' do
      @order_item.order.calculated_at = Time.now
      @order_item.set_order_calculated_at_to_nil
      @order_item.order.calculated_at.should == nil
    end
  end

  context ".ready_to_calculate?" do
    it 'is ready to calculate if we know the shipping rate and tax rate' do
      @order_item.tax_rate_id = 1
      @order_item.ready_to_calculate?.should be_true
    end

    it 'is not ready to calculate if we know the tax rate' do
      @order_item.tax_rate_id = nil
      @order_item.ready_to_calculate?.should be_false
    end
  end
end
describe OrderItem, "Without VAT" do

  before(:all) do
    Settings.vat = false
  end
  context ".calculate_total(coupon = nil)" do
    it 'calculate_total' do
      tax_rate = create(:tax_rate, :percentage => 10.0)
      order_item = create(:order_item, :tax_rate => tax_rate, :price => 20.00)
      order_item.calculate_total
      order_item.total.should == 20.00
    end
  end

  context ".tax_charge" do
    it 'returns tax_charge' do
      tax_rate = create(:tax_rate, :percentage => 10.0)
      order_item = create(:order_item, :tax_rate => tax_rate, :price => 20.00)
      order_item.tax_charge.should == 2.00
    end
  end

  context ".amount_of_charge_is_vat" do
    it 'returns tax_charge' do
      tax_rate = create(:tax_rate, :percentage => 10.0)
      order_item = create(:order_item, :tax_rate => tax_rate, :price => 20.00)
      order_item.amount_of_charge_is_vat.should == 0.00
    end
  end

  context ".amount_of_charge_without_vat" do
    it 'returns tax_charge' do
      tax_rate = create(:tax_rate, :percentage => 10.0)
      order_item = create(:order_item, :tax_rate => tax_rate, :price => 20.00)
      order_item.amount_of_charge_without_vat.should == 20.00
    end
  end
end
describe OrderItem, "With VAT" do
  before(:all) do
    Settings.vat = true
  end
  context ".calculate_total(coupon = nil)" do
    it 'calculate_total' do
      tax_rate = create(:tax_rate, :percentage => 10.0)
      order_item = create(:order_item, :tax_rate => tax_rate, :price => 20.00)
      order_item.calculate_total
      order_item.total.should == 20.00
    end
  end

  context ".tax_charge" do
    it 'returns tax_charge' do
      tax_rate = create(:tax_rate, :percentage => 10.0)
      order_item = create(:order_item, :tax_rate => tax_rate, :price => 20.00)
      order_item.tax_charge.should == 0.00
    end
  end

  context ".amount_of_charge_is_vat" do
    it 'returns tax_charge' do
      tax_rate = create(:tax_rate, :percentage => 10.0)
      order_item = create(:order_item, :tax_rate => tax_rate, :price => 20.00)
      order_item.amount_of_charge_is_vat.should == 1.82
    end
  end

  context ".amount_of_charge_without_vat" do
    it 'returns tax_charge' do
      tax_rate = create(:tax_rate, :percentage => 10.0)
      order_item = create(:order_item, :tax_rate => tax_rate, :price => 20.00)
      order_item.amount_of_charge_without_vat.should == 18.18
    end
  end
end
