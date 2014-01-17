require 'spec_helper'

describe PurchaseOrder do
  before(:each) do
    @purchase_order = build(:purchase_order)
  end

  it "is valid with minimum attribues" do
    @purchase_order.should be_valid
  end
end

describe PurchaseOrder, ".display_received" do
  it "returns Yes when true" do
    order = build(:purchase_order)
    order.stubs(:is_received).returns(true)

    order.display_received == "Yes"
  end
end

describe PurchaseOrder, ".display_received" do
  it "returns No when false" do
    order = build(:purchase_order)
    order.stubs(:is_received).returns(false)

    order.display_received == "No"
  end
end

describe PurchaseOrder, ".display_estimated_arrival_on" do
  it "returns the correct name" do
    order = build(:purchase_order)
    now = Time.now
    order.stubs(:estimated_arrival_on).returns(now.to_date)

    order.display_estimated_arrival_on == now.to_s(:us_date)
  end
end

describe PurchaseOrder, ".supplier_name" do
  it "returns the correct name" do
    order = build(:purchase_order)
    supplier = build(:supplier)
    supplier.stubs(:name).returns("Supplier Test")
    order.stubs(:supplier).returns(supplier)

    order.supplier_name == "Supplier Test"
  end
end

describe PurchaseOrder, 'instance methods' do
  before(:each) do
    @purchase_order = create(:purchase_order, :state => 'pending')
    @purchase_order.purchase_order_variants.push(create(:purchase_order_variant, :purchase_order => @purchase_order, :is_received => false))
  end

  context ".receive_po=(answer)" do
    it 'calls receive_variants' do
      @purchase_order.expects(:receive_variants).once
      @purchase_order.receive_po=('1')
    end

    it 'calls receive_variants' do
      @purchase_order.expects(:receive_variants).once
      @purchase_order.receive_po=('true')
    end

    it 'does not call receive_variants' do
      @purchase_order.expects(:receive_variants).never
      @purchase_order.receive_po=('0')
    end

    it 'does not call receive_variants' do
      @purchase_order.state = 'received'
      @purchase_order.expects(:receive_variants).never
      @purchase_order.receive_po=('1')
    end
  end

  context ".receive_po" do
    it 'returns true if state is received' do
      @purchase_order.state = PurchaseOrder::RECEIVED
      @purchase_order.receive_po.should be_true
    end

    it 'returns false if state is not received' do
      @purchase_order.state = PurchaseOrder::PENDING
      @purchase_order.receive_po.should be_false
    end
  end

  context ".display_tracking_number" do
    it 'displays N/A if the tracking number is nil' do
      @purchase_order.tracking_number = nil
      @purchase_order.display_tracking_number.should == 'N/A'
    end
  end
end

describe PurchaseOrder, ".pay_for_order" do
  it 'pay for the order ' do
    purchase_order = create(:purchase_order, :state => 'pending', :total_cost => 20.32)
    cash_debits = []
    cash_credits = []
    expense_debits = []
    expense_credits = []
    purchase_order.transaction_ledgers.each do |ledger|
      if ledger.transaction_account_id == TransactionAccount::EXPENSE_ID
        expense_credits << ledger.credit
        expense_debits  << ledger.debit
      end
      if ledger.transaction_account_id == TransactionAccount::CASH_ID
        cash_credits << ledger.credit
        cash_debits  << ledger.debit
      end
    end
    
    expense_credits.sum.should  == 0.0
    cash_credits.sum.should     == expense_debits.sum
    cash_debits.sum.should      == expense_credits.sum
  end
end

describe PurchaseOrder, ".receive_variants" do
  it 'receive PO_varaints ' do
    purchase_order = create(:purchase_order, :state => 'pending')
    purchase_order.purchase_order_variants.push(create(:purchase_order_variant, :purchase_order => purchase_order, :is_received => false))
    PurchaseOrderVariant.any_instance.expects(:receive!).once
    purchase_order.receive_variants
  end

  it 'does not receive PO_varaints ' do
    purchase_order = create(:purchase_order, :state => 'pending')
    purchase_order.purchase_order_variants.push(create(:purchase_order_variant, :purchase_order => purchase_order, :is_received => true))
    PurchaseOrderVariant.any_instance.expects(:receive!).never
    purchase_order.receive_variants
  end
end