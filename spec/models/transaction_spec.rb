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



  context 'when accepted' do
    let(:accepted_transaction)     { build :accepted_transaction }
    it 'has status accepted' do
      expect(accepted_transaction.status).to eq 'accepted'
    end

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
  end
end
