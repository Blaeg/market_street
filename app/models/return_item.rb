# == Schema Information
#
# Table name: return_items
#
#  id                      :integer(4)      not null, primary key
#  return_authorization_id :integer(4)      not null
#  order_item_id           :integer(4)      not null
#  return_condition        :string
#  return_reason           :string
#  returned                :boolean(1)      default(FALSE)
#  updated_by              :integer(4)
#  created_at              :datetime
#  updated_at              :datetime
#

class ReturnItem < ActiveRecord::Base
  CONDITIONS = {'GOOD' => 'Good', 
                'DEFECTIVE' => 'Defective',
                'DAMAGED' => 'Worn / Damaged' }

  REASONS = { 'DEFECTIVE' => 'Defective',
              'POOR_QUALITY' => 'Poor Quality',
              'WRONG_ITEM' => 'Wrong Item',
              'WRONG_SIZE' => 'Wrong Size/Color',
              'ARRIVED_LATE' => 'Arrived too late',
              'OTHER' => 'Other' }

  belongs_to :return_authorization
  belongs_to :order_item
  belongs_to :last_author, :class_name => 'User', :foreign_key => :updated_by
  belongs_to :author, :class_name => 'User', :foreign_key => "created_by"

  validates :order_item_id, :presence => true
  validates :return_condition, :inclusion => CONDITIONS.keys
  validates :return_reason, :inclusion => REASONS.keys
  
  def mark_returned!
    self.returned = true
    self.order_item.return!
    save
  end

  def self.select_reasons_form
    reasons = []
    CONDITIONS.each_pair {|k, v| reasons << [v, k]}
    reasons
  end

  def self.select_conditions_form
    conditions = []
    CONDITIONS.each_pair {|k, v| conditions << [v, k]}
    conditions 
  end
end