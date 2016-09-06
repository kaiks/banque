class Transaction < ActiveRecord::Base
  belongs_to :account
  enum status: [:waiting, :refused, :accepted]
  enum type: [:debit, :credit]


end
