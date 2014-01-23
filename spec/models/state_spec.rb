require 'spec_helper'

describe State, " methods" do
  before(:each) do
    @state ||= State.new( :abbreviation => 'CA', :name => 'California')
    #@mock_state.stub!(:abbreviation).and_return  'CA'
    #@mock_state.stub!(:name).and_return  'California'
  end

  context ".abbreviation_name(append_name = )" do

    it 'returns the correct string with no params' do
      @state.abbreviation_name.should == 'CA - California'
    end

    it 'returns the correct string with  params' do
      @state.abbreviation_name('JJJ').should == 'CA - California JJJ'
    end
  end

  context ".abbreviation_name" do
    it 'returns the correct string' do
      @state.abbreviation_name.should == 'CA - California'
    end
  end
end

describe State, "class methods" do
  context "#form_selector" do
    FactoryGirl.create(:state)
    @states = State.form_selector
    @states.class.should              == Array
    @states.first.class.should        == Array
    @states.first.first.class.should  == String
    @states.first.last.class.should   == Fixnum
  end

  context 'all_with_country_id(country_code)' do
    before(:each) do
      @states = FactoryGirl.create_list(:state, 2, :country_code => 'US')
    end

    it 'returns an array of States' do
      @states.first.class.should        == State
    end

    it 'states with country id == country_code' do
      @states.first.country_code.should == 'US'
    end
  end
end
