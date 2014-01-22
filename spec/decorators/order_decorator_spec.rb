require 'spec_helper'

describe OrderDecorator do
	let(:order) { OrderDecorator.decorate(create(:order)) }
	
	describe ".display_completed_at(format = :us_date)" do    
    it 'returns the completed date in us format' do
      order.stubs(:completed_at).returns(Time.zone.parse('2010-03-20 14:00:00'))
      expect(order.display_completed_at).to eq '03/20/2010'
    end

    it 'returns "Not Finished."' do
      order.stubs(:completed_at).returns(nil)
      expect(order.display_completed_at).to eq "Not Finished."
    end
  end
end
