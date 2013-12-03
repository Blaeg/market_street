require 'spec_helper'

describe Batch do
  context " Batch" do
    before(:each) do
      @batch = build(:batch)
    end
    
    it "is valid with minimum attribues" do
      @batch.should be_valid
    end
    
  end
  
end

