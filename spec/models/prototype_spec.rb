require 'spec_helper'

describe Prototype do
  before(:each) do
    @prototype = build(:prototype)
  end

  it "is valid with minimum attribues" do
    @prototype.should be_valid
  end
end