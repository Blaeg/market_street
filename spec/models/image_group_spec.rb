require File.dirname(__FILE__) + '/../spec_helper'

describe ImageGroup do
  context "a valid instance" do
    it "is valid" do
      expect(ImageGroup.new(:product_id => 1, :name => 'test')).to be_valid
    end
  end
end
