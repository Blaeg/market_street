require 'spec_helper'

describe UserRole do
  
  describe "valid UserRole model" do 
    
    it "is valid" do
      @user_role = build(:user_role)
      @user_role.should be_valid
    end
    
  end
end
