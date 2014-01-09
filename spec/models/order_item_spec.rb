require 'spec_helper'

describe OrderItem, "instance methods" do
  let(:order_item) { create(:order_item) }
  
  context ".calculate_order" do
    xit 'calculate order once after calling method twice' do
      order     = mock()
      order_item.stubs(:ready_to_calculate?).returns(true)
      order_item.stubs(:order).returns(order)
      #order_item.order.expects(:calculate_totals).once
      order_item.calculate_order
      order_item.calculate_order
    end
  end  
end

describe OrderItem, "Without VAT" do
  before(:all) do
    Settings.vat = false
  end
  
  context ".calculate_total(coupon = nil)" do
    xit 'calculate_total' do
      order_item = create(:order_item, :price => 20.00)
      order_item.calculate_total
      order_item.total.should == 20.00
    end
  end

  context ".tax_charge" do
    xit 'returns tax_charge' do
      tax_rate = create(:tax_rate, :percentage => 10.0)
      order_item = create(:order_item, :tax_rate => tax_rate, :price => 20.00)
      order_item.tax_charge.should == 2.00
    end
  end

  context ".amount_of_charge_is_vat" do
    xit 'returns tax_charge' do
      tax_rate = create(:tax_rate, :percentage => 10.0)
      order_item = create(:order_item, :tax_rate => tax_rate, :price => 20.00)
      order_item.amount_of_charge_is_vat.should == 0.00
    end
  end

  context ".amount_of_charge_without_vat" do
    xit 'returns tax_charge' do
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
    xit 'calculate_total' do
      tax_rate = create(:tax_rate, :percentage => 10.0)
      order_item = create(:order_item, :tax_rate => tax_rate, :price => 20.00)
      order_item.calculate_total
      order_item.total.should == 20.00
    end
  end

  context ".tax_charge" do
    xit 'returns tax_charge' do
      tax_rate = create(:tax_rate, :percentage => 10.0)
      order_item = create(:order_item, :tax_rate => tax_rate, :price => 20.00)
      order_item.tax_charge.should == 0.00
    end
  end

  context ".amount_of_charge_is_vat" do
    xit 'returns tax_charge' do
      tax_rate = create(:tax_rate, :percentage => 10.0)
      order_item = create(:order_item, :tax_rate => tax_rate, :price => 20.00)
      order_item.amount_of_charge_is_vat.should == 1.82
    end
  end

  context ".amount_of_charge_without_vat" do
    xit 'returns tax_charge' do
      tax_rate = create(:tax_rate, :percentage => 10.0)
      order_item = create(:order_item, :tax_rate => tax_rate, :price => 20.00)
      order_item.amount_of_charge_without_vat.should == 18.18
    end
  end
end
