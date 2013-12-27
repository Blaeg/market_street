require 'spec_helper'

describe Country do
  context "#form_selector" do
    FactoryGirl.create(:country)
    @countries = Country.form_selector
    @countries.class.to_s.should              == 'Array'
    @countries.first.class.to_s.should        == 'Array'
    @countries.first.first.class.to_s.should  == 'String'
    @countries.first.last.class.to_s.should   == 'Fixnum'
  end
end

describe Country do
  before(:each) do
    @country ||= Country.new( :abbreviation => 'US', :name => 'United States')
  end

  context ".abbreviation_name(append_name = )" do

    it 'returns the correct string with no params' do
      @country.abbreviation_name.should == 'US - United States'
    end

    it 'returns the correct string with  params' do
      @country.abbreviation_name('JJJ').should == 'US - United States JJJ'
    end
  end

  context ".abbreviation_name" do
    it 'returns the correct string' do
      @country.abbreviation_name.should == 'US - United States'
    end
  end
end