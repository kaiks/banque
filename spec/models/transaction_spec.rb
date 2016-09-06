require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:bracket)     { FactoryGirl.create :income_bracket }
  let(:user)        { FactoryGirl.create :user, income_bracket: bracket }
  let(:account)     { FactoryGirl.create :account, user: user }
  let(:transaction) { FactoryGirl.create :transaction, account: account }

  context 'when accepted' do
    it 'must have administrator' do
      expect{transaction.accepted!}.to raise_error ActiveRecord::RecordInvalid
    end

    it 'must have date' do
      expect{transaction.accepted!}.to raise_error ActiveRecord::RecordInvalid
    end
  end

  it 'must have positive amount' do
    expect { transaction.amount = -3
              }.to raise_error ActiveRecord::RecordInvalid
  end

  it 'must be rounded to two digits' do
    expect { transaction.amount = 123.456
              }.to raise_error ActiveRecord::RecordInvalid
  end

  it 'can\'t have date without administrator'

end
