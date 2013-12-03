require 'spec_helper'

describe TransactionLedger do
  context " TransactionLedger" do
    before(:each) do
      @transaction_ledger = create(:transaction_ledger)
    end
    
    it "is valid with minimum attribues" do
      @transaction_ledger.should be_valid
    end    
  end  
end