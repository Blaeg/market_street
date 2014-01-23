require 'spec_helper'

describe Address do
  context "Valid Address" do
    before(:each) do
      User.any_instance.stubs(:start_store_credits).returns(true)  ## simply speed up tests, no reason to have store_credit object
      @address = build(:address)
    end

    it "is valid with minimum attribues" do
      @address.should be_valid
    end
  end
end

describe Address, "methods" do
  let(:state) { FactoryGirl.create(:state)}
  let(:address) { Address.new(:first_name => 'Perez',
                          :last_name  => 'Hilton',
                          :address1   => '7th street',
                          :city       => 'Fredville',
                          :state   => state,
                          :state_id => state.id,
                          :zip_code   => '13156',
                          :address_type  => 'BILL',
                          :country_code => state.country_code
                          )}
  before(:each) do
    User.any_instance.stubs(:start_store_credits).returns(true)  ## simply speed up tests, no reason to have store_credit object
    state = FactoryGirl.create(:state)
    @user = FactoryGirl.create(:user)
    @address = address
    @user.addresses << address
  end

  context ".name" do
    it 'returns the correct string with no params' do
      @address.name.should == 'Perez Hilton'
    end
  end

  context ".inactive!" do
    it 'inactivate the address' do
      @address.save
      @address.inactive!
      expect(@address).not_to be_active
    end
  end

  context ".address_attributes" do
    #attributes.delete_if {|key, value| ["id", 'updated_at', 'created_at'].any?{|k| k == key }}
    it 'returns all the address attributes except id, updated and created_at' do
      @address.save
      attributes = @address.address_attributes
      attributes['id'].should be_nil
      attributes['created_at'].should be_nil
      attributes['updated_at'].should be_nil
      attributes['first_name'].should == 'Perez'
    end
  end

  context ".cc_params" do
    it 'returns the params needed by the credit card vaults' do
      cc_params = @address.cc_params
      cc_params[:name].should    == 'Perez Hilton'
      cc_params[:address1].should == '7th street'
      cc_params[:city].should    == 'Fredville'
      cc_params[:state].should   == 'CA'
      cc_params[:zip].should     == '13156'
      cc_params[:country_code].should == 'US'
    end
  end

  context '.full_address_array' do
    it 'returns an array of address lines and name' do
      @address.full_address_array.should == ['Perez Hilton','7th street','Fredville, CA 13156']
    end
  end

  context ".address_lines" do
    # def address_lines(join_chars = ', ')
    # [address1, address2].delete_if{|add| add.blank?}.join(join_chars)
    it 'displays the address lines' do
      @address.address_lines.should == '7th street'
      @address.address2 = 'test'
      @address.address_lines.should == '7th street, test'
      @address.address_lines(' H ').should == '7th street H test'
    end
  end

  context ".state_abbr_name" do
    it 'displays the state_abbr_name' do
      @address.state_abbr_name.should == @address.state.abbreviation
    end
  end

  describe Address, ".city_state_name" do
    it 'displays the state_abbr_name' do
      @address.city_state_name.should == "Fredville, #{@address.state.abbreviation}"
    end
  end

  describe Address, ".city_state_zip" do
    it 'displays the city_state_zip' do
      @address.city_state_zip.should == "Fredville, #{@address.state.abbreviation} 13156"
    end
  end

  describe Address, ".sanitize_data" do
    let(:state) {FactoryGirl.create(:state)}
    let(:address) { Address.new(:first_name => ' Perez ',
                            :last_name  => ' Hilton ',
                            :address1   => ' 1st street ',
                            :address2   => ' 2nd street ',
                            :city       => ' Fredville ',
                            :state_id => state.id,
                            :zip_code   => ' 13156 ',
                            :address_type => 'BILL',
                            )}
    it "sanitizes data" do 
      address.send(:sanitize_data)
      address.first_name.should ==  'Perez'
      address.last_name.should  ==  'Hilton'
      address.city.should       ==  'Fredville'
        address.zip_code.should ==  '13156'
        address.address1.should ==  '1st street'
        address.address2.should ==  '2nd street'
    end
  end
end

describe Address, "#save" do

  before(:each) do
    @user     = FactoryGirl.create(:user)
    @address  = FactoryGirl.create(:address, :addressable => @user)
  end

  it "only the last default address should be the default address" do
    @address2  = FactoryGirl.create(:address, :addressable => @user)
    @address2.ship_default = true
    @address2.save
    
    @address.ship_default = true
    @address.save
    
    expect(@address.reload.ship_default).to be_true
    expect(@address2.reload.ship_default).not_to be_true    
  end
end

describe Address do
  describe "before save" do
    it "#invalidates_old_defaults" do
      old_address = FactoryGirl.create(:address, ship_default: true, bill_default: true)
      new_address = old_address.dup
      new_address.save
      
      old_address.reload
      old_address.should_not be_ship_default
      old_address.should_not be_bill_default
    end

    context "when #replace_address_id is set" do
      it "replaces the address" do
        old_address = FactoryGirl.create(:address)
        old_address.should be_active
        new_address = old_address.dup
        new_address.replace_address_id = old_address.id
        new_address.save
        old_address.reload
        old_address.should_not be_active
      end
    end
  end
end
