class Transaction < ActiveRecord::Base
  belongs_to :account
  belongs_to :admin, foreign_key: :managed_by

  enum status: [:waiting, :refused, :accepted]
  enum transaction_type: [:debit, :credit]

  validates :amount, :numericality => { :greater_than => 0,
    :message => 'Le montant de la transaction doit excéder 0.'}
  validate :must_be_rounded

  validates :managed_by, presence: true, unless: 'managed_at.nil?'
  validates :account, presence: true

  with_options if: :accepted? do |transaction|
    transaction.validates :managed_by, presence: true
    transaction.validates :managed_at, presence: true
  end

  validate :change_validation, if: :changed?
  validate :account_state_validation

  def rounded?
    (100*amount).floor == amount*100
  end

  def balance_change
    transaction_type == 'debit' ? amount : -amount
  end

  def user
    account.user
  end


  private
  def must_be_rounded
    errors.add :base, 'Le montant doit être un multiple de 0.01' unless amount.nil? or rounded?
  end

  def change_validation
    if persisted?
      if changed.include?('status') && status_was == 'waiting'
        update_balance
      else
        errors.add :base, 'On ne peut pas changer la transaction après qu\'elle soit sauvegardée'
      end
    end
  end

  def account_state_validation
    return if account.nil?
    if account.closed?
      errors.add :base, 'Operation impossible pour un compte fermé'
    elsif account.waiting? and accepted?
      errors.add :base, 'Transaction ne peut pas être acceptée pour un compte en attente'
    end
  end

  def update_balance
    account.balance += balance_change
    account.save!
  end

end
