require 'spec_helper'

describe Inventory do
  before(:each) do 
    @inventory = FactoryGirl.build(:inventory)
  end
  context 'validation working' do
    it 'does not save inventory below out_of_stock limit' do
      @inventory.assign_attributes(
        :count_on_hand => 10,
        :count_pending_to_customer => 11)
      @inventory.valid?.should == false
    end

    it 'does not save inventory below out_of_stock limit' do
      @inventory.assign_attributes(
        :count_on_hand => 10,
        :count_pending_to_customer => 9)
      @inventory.valid?.should == true
      @inventory.save.should be_true
    end

    it 'does not save inventory below out_of_stock limit' do
      @inventory.assign_attributes(
        :count_on_hand => 100 ,
        :count_pending_to_customer => 101 - Variant::LOW_STOCK_QTY)
      @inventory.valid?.should == true
    end
    it 'does not save inventory below out_of_stock limit' do
      @inventory.assign_attributes(
        :count_on_hand => 100 + Variant::LOW_STOCK_QTY,
        :count_pending_to_customer => 0)
      @inventory.valid?.should == true
    end
  end
end
