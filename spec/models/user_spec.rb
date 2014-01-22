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

describe User, ".name" do
  let(:user) { User.decorator.decorate(build(:user)) } 
  it "returns the correct name" do
    user.stubs(:first_name).returns("Fred")
    user.stubs(:last_name).returns("Flint")
    user.name.should == "Fred Flint"
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

  context ".email_address_with_name" do
    let(:user) { User.decorator.decorate(user) } 
    
    it 'show the persons name and email address' do
      user.email       = 'myfake@email.com'
      user.first_name  = 'Dave'
      user.last_name   = 'Commerce'
      expect(user.email_address_with_name).to eq '"Dave Commerce" <myfake@email.com>'
    end
  end

  context ".merchant_description" do
    it 'show the name and address lines' do
      address = create(:address, :address1 => 'Line one street', :address2 => 'Line two street')
      @user.first_name = 'First'
      @user.last_name  = 'Second'

      @user.stubs(:default_shipping_address).returns(address)
      @user.merchant_description.should == 'First Second, Line one street, Line two street'
    end

    it 'show the name and address lines without address2' do
      address = create(:address, :address1 => 'Line one street', :address2 => nil)
      @user.first_name = 'First'
      @user.last_name  = 'Second'

      @user.stubs(:default_shipping_address).returns(address)
      @user.merchant_description.should == 'First Second, Line one street'
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

  context ".create_cim_profile" do
    pending "test for create_cim_profile"
  end

  context ".before_validation_on_create" do
    #UserMailer.expects(:signup_notification).once.returns(sign_up_mock)
    it 'assign the access_token' do
      user = build(:user)
      user.expects(:before_validation_on_create).once
      user.save
    end
    it 'assign the access_token' do
      @user.save
      @user.access_token.should_not be_nil
    end
  end

  context ".user_profile" do
    #{:merchant_customer_id => self.id, :email => self.email, :description => self.merchant_description}
    it 'returns a hash of user info' do
      @user.save
      profile = @user.send(:user_profile)
      profile.keys.include?(:merchant_customer_id).should be_true
      profile.keys.include?(:email).should be_true
      profile.keys.include?(:description).should be_true
    end
  end
end