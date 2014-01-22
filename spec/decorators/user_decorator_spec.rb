require 'spec_helper'

describe UserDecorator do
	let(:user) { UserDecorator.decorate(create(:user))}

	describe User, ".name" do
	  it "returns the correct name" do
	    user.stubs(:first_name).returns("Fred")
	    user.stubs(:last_name).returns("Flint")
	    user.display_name.should == "Fred Flint"
	  end
	end
	
	describe User,  ".email_address_with_name" do
    it 'show the persons name and email address' do
      user.email       = 'myfake@email.com'
      user.first_name  = 'Dave'
      user.last_name   = 'Commerce'
      expect(user.email_address_with_name).to eq '"Dave Commerce" <myfake@email.com>'
    end
  end

  describe User,  ".merchant_description" do
    let(:user) { UserDecorator.decorate(create(:user)) }
    let(:address1) { create(:address, :address1 => 'Line one street', 
        :address2 => 'Line two street') } 
    let(:address2) { create(:address, :address1 => 'Line one street', 
      :address2 => nil)}

    it 'show the name and address lines' do
      user.first_name = 'First'
      user.last_name  = 'Second'
      user.stubs(:default_shipping_address).returns(address1)
      user.merchant_description.should == 'First Second, Line one street, Line two street'
    end

    it 'show the name and address lines without address2' do
      user.first_name = 'First'
      user.last_name  = 'Second'
      user.stubs(:default_shipping_address).returns(address2)
      user.merchant_description.should == 'First Second, Line one street'
    end
  end

	describe User,  ".user_profile" do
    it 'returns a hash of user info' do
      user.save
      profile = user.send(:user_profile)
      profile.keys.include?(:merchant_customer_id).should be_true
      profile.keys.include?(:email).should be_true
      profile.keys.include?(:description).should be_true
    end
  end
end