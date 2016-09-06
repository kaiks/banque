class Transaction < ActiveRecord::Base
  belongs_to :account
  belongs_to :admin, foreign_key: :managed_by

  enum status: [:waiting, :refused, :accepted]
  enum type: [:debit, :credit]
  validates :amount, :numericality => { :greater_than => 0,
    :message => 'Le montant de la transaction doit excéder 0.'}
  validate :must_be_rounded
  validates :managed_by, presence: true, unless: 'managed_at.nil?'

  with_options if: :accepted? do |transaction|
    transaction.validates :managed_by, presence: true
    transaction.validates :managed_at, presence: true
  end


  def rounded?
    (100*amount).floor == amount*100
  end

  private
  def must_be_rounded
    errors.add :base, 'Le montant doit être un multiple de 0.01' unless rounded?
  end
end
