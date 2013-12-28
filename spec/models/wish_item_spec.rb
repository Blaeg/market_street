require 'spec_helper'

describe WishItem do
  let(:wish_item) { create(:wish_item) }

  it "validates" do 
  	expect(wish_item).to be_valid
  end
end
