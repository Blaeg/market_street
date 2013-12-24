require 'spec_helper'

describe Property do
  context "Valid Property" do
    before(:each) do
      @property = build(:property)
    end

    it "is valid with minimum attributes" do
      @property.should be_valid
    end
  end

end

describe Property, ".display_active" do
  before(:each) do
    @property = build(:property)
  end

  it 'displays True if true' do
    @property.active = true
    @property.display_active.should == 'True'
  end

  it 'displays False if false' do
    @property.active = false
    @property.display_active.should == 'False'
  end
end
