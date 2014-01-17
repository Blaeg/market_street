# == Schema Information
#
# Table name: transactions
#
#  id         :integer(4)      not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Several classes inhertit this class.  This class describes the transaction type in the accounting system
#
class Transaction < ActiveRecord::Base
  has_many :transaction_ledgers

  validates :type,        :presence => true

  def new_transaction_ledgers( transactor, credit_transaction_account_id, debit_transaction_account_id, amount, at)
    transaction_ledgers.push( transactor.new_credit(credit_transaction_account_id, amount, at) )
    transaction_ledgers.push( transactor.new_debit(debit_transaction_account_id, amount, at) )
  end
end
