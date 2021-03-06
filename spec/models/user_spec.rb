require 'spec_helper'

describe User do
  context "Valid User" do
    before(:each) do
      @user = build(:user)
    end

    it "is valid with minimum attributes" do
      @user.should be_valid
    end

  end

  context "Invalid User" do
    it "is valid without first_name" do
      @user = build(:user, :first_name => '')
      @user.should_not be_valid
    end

  end
end

describe User, "instance methods" do
  before(:each) do
    User.any_instance.stubs(:start_store_credits).returns(true)  ## simply speed up tests, no reason to have store_credit object
  end

  context ".admin?" do
    it 'ahould be an admin' do
      user = create_admin_user
      user.admin?.should be_true
    end

    it 'ahould be an admin' do
      user = create_super_admin_user
      user.admin?.should be_true
    end

    it 'ahould not be an admin' do
      user = create(:user)
      user.admin?.should be_false
    end
  end
end

describe User, "instance methods" do
  before(:each) do
    User.any_instance.stubs(:start_store_credits).returns(true)  ## simply speed up tests, no reason to have store_credit object
    @user = create(:user)
  end

  context ".active?" do
    it 'is not active' do
      @user.state = 'canceled'
      @user.active?.should be_false
      @user.state = 'inactive'
      @user.active?.should be_false
    end

  end

  context ".current_cart" do
    it 'use the last cart' do
      cart1 = @user.carts.new
      cart1.save
      cart2 = @user.carts.new
      cart2.save
      @user.current_cart.should == cart2
    end
  end

  context ".might_be_interested_in_these_products" do
    it 'find products' do
      product = create(:product)
      @user.might_be_interested_in_these_products.include?(product).should be_true
    end

    #pending "add your specific find products method here"
  end

  context ".bill_address" do
    # default_billing_address ? default_billing_address : default_shipping_address
    it 'returns nil if you dont have an address' do
      #add = create(:address, :addressable => @user, :default => true)
      @user.bill_address.should be_nil
    end

    it 'use your shipping address if you dont have a default billing address' do
      add = create(:address, :addressable => @user, :ship_default => true)
      @user.bill_address.should == add
    end

    it 'use your default billing address if you have one available' do
      add = create(:address, :addressable => @user, :ship_default => true)
      bill_add = create(:address, :addressable => @user, :bill_default => true)
      @user.bill_address.should == bill_add
    end

    it 'returns the first address if not defaults are set' do
      #add = create(:address, :addressable => @user, :default => true)
      add = create(:address, :addressable => @user)
      @user.bill_address.should == add
    end
  end

  context ".ship_address" do
    # default_billing_address ? default_billing_address : default_shipping_address
    it 'returns nil if you dont have an address' do
      #add = create(:address, :addressable => @user, :default => true)
      @user.ship_address.should be_nil
    end

    it 'use your default shipping address if you have one available' do
      add = create(:address, :addressable => @user, :ship_default => true)
      bill_add = create(:address, :addressable => @user, :bill_default => true)
      @user.ship_address.should == add
    end

    it 'returns the first address if not defaults are set' do
      #add = create(:address, :addressable => @user, :default => true)
      add = create(:address, :addressable => @user)
      @user.ship_address.should == add
    end
  end

  context ".registered_user?" do
    # registered?

    it 'is not a registered user' do
      @user.state = 'active'
      @user.registered_user?.should be_true
    end

    it 'is not a registered user' do
      @user.state = 'canceled'
      @user.registered_user?.should be_false
    end
  end

  context ".sanitize_data" do
    it "sanitize data" do
      @user.email           = ' bad@email.com '
      @user.first_name      = ' bAd NamE '
      @user.last_name       = ' lastnamE '
      
      @user.sanitize_data

      @user.email.should        == 'bad@email.com'
      @user.first_name.should   == 'Bad name'
      @user.last_name.should    == 'Lastname'      
    end
  end
end

describe User, 'store_credit methods' do
  context '.start_store_credits' do
    let(:user) { create(:user) }
    it 'create store_credit object on create' do
      expect(user.store_credit).not_to be_nil
      expect(user.store_credit.id).not_to be_nil      
    end
  end
end

describe User, 'private methods' do

  before(:each) do
    User.any_instance.stubs(:start_store_credits).returns(true)  ## simply speed up tests, no reason to have store_credit object
    @user = build(:user)
  end

  context ".password_required?" do
    it 'require a password if the crypted password is blank' do
      @user.crypted_password = nil
      @user.send(:password_required?).should be_true
    end

    it 'does not require a password if the crypted password is present' do
      @user.crypted_password = 'blah'
      @user.send(:password_required?).should be_false
    end
  end

  context ".before_validation_on_create" do
    let(:user) { build(:user) }
    
    it 'assign the access_token' do      
      user.expects(:before_validation_on_create).once
      user.save
    end

    it 'assign the access_token' do
      @user.save
      @user.access_token.should_not be_nil
    end
  end  
end