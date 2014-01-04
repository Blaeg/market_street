# == Schema Information
#
# Table name: store_credits
#
#  id         :integer(4)      not null, primary key
#  amount     :decimal(8, 2)   default(0.0)
#  user_id    :integer(4)      not null
#  created_at :datetime
#  updated_at :datetime
#

class StoreCredit < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :presence => true
  validates :amount , :presence => true

  after_find :ensure_sql_math_rounding_issues
  
  def remove_credit(amount_to_remove)
    sql = "UPDATE store_credits SET amount = (amount - #{amount_to_remove.to_f.round_at(2)}) WHERE id = #{self.id}"
    ActiveRecord::Base.connection.execute(sql)
  end

  def add_credit(amount_to_add)
    sql = "UPDATE store_credits SET amount = (amount + #{amount_to_add}) WHERE id = #{self.id}"
    ActiveRecord::Base.connection.execute(sql)
  end

  private

  def ensure_sql_math_rounding_issues
    self.amount = amount.to_f.round_at(2)
  end
end
