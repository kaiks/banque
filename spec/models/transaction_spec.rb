require 'rails_helper'
require_relative '../shared_stuff.rb'

RSpec.describe Transaction, type: :model do
  include_context 'shared stuff'

  it 'passes with all parameters' do
    expect(transaction).to be_valid
  end

  it 'cant have undefined amount' do
    transaction.amount = nil
    expect(transaction).to be_invalid
  end

  it 'must belong to an account' do
    transaction.account = nil
    expect(transaction).to be_invalid
  end

  it 'must belong to a valid account' do
    transaction.account_id = 432432
    expect(transaction).to be_invalid
  end

  it 'must have positive amount' do
    transaction.amount = -3
    expect(transaction).to be_invalid
  end

  it 'must be rounded to two digits' do
    transaction.amount = 123.456
    expect(transaction).to be_invalid
  end

  it "can't have date without administrator" do
    transaction.managed_at = DateTime.now
    expect(transaction).to be_invalid
  end



  context 'when not waiting' do
    let(:accepted_transaction)     { build :accepted_transaction }

    it 'passes with admin and date' do
      expect(accepted_transaction).to be_valid
    end

    it 'must have administrator' do
      accepted_transaction.managed_by = nil
      expect(accepted_transaction).to be_invalid
    end

    it 'must have date' do
      accepted_transaction.managed_at = nil
      expect(accepted_transaction).to be_invalid
    end

    context 'when accepted' do
      it 'has status accepted' do
        expect(accepted_transaction.status).to eq 'accepted'
      end

      it 'changes account balance' do
        accepted_transaction.waiting!
        balance_before = accepted_transaction.account.balance
        accepted_transaction.accepted!
        balance_after  = accepted_transaction.account.balance
        expect(balance_after).to eq (balance_before + accepted_transaction.balance_change)
      end

      it 'status cant be changed' do
        accepted_transaction.save!
        expect{accepted_transaction.refused!}.to raise_error
        expect{accepted_transaction.waiting!}.to raise_error
      end
    end

    context 'when refused' do
      let(:refused_transaction)     { build :refused_transaction }
      it 'doesnt change account balance' do
        balance_before = refused_transaction.account.balance
        refused_transaction.save!
        balance_after  = refused_transaction.account.balance
        expect(balance_after).to eq (balance_before)
      end
    end
  end

  context 'when waiting' do
    before { account.save! }

    it 'doesnt change account balance' do
      balance_before = transaction.account.balance
      transaction.save!
      balance_after  = transaction.account.balance
      expect(balance_after).to eq (balance_before)
    end
  end

  describe '.balance_change' do
    include_context 'shared stuff'
    context 'when type is debit' do
      it 'is positive' do
        transaction.type = 'debit'
        expect(transaction.balance_change).to eq transaction.amount
      end
    end

    context 'when type is credit' do
      it 'is negative' do
        transaction.type = 'credit'
        expect(transaction.balance_change).to eq -transaction.amount
    end
    end
  end

end
