require 'rails_helper'
require_relative '../shared_stuff.rb'

RSpec.describe Transaction, type: :model do
  include_context 'shared stuff'

  context 'when accepted' do
    it 'must have administrator' do
      expect{transaction.accepted!}.to raise_error ActiveRecord::RecordInvalid
    end

    it 'must have date' do
      transaction.managed_by = admin
      expect{transaction.accepted!}.to raise_error ActiveRecord::RecordInvalid
    end

    it 'passes with date and administrator' do
      transaction.managed_by = admin.id
      transaction.managed_at = DateTime.now
      expect{transaction.accepted!}.not_to raise_error
    end
  end

  it 'must have positive amount' do
    transaction.amount = -3
    expect {  transaction.save! }.to raise_error ActiveRecord::RecordInvalid
  end

  it 'must be rounded to two digits' do
    transaction.amount = 123.456
    expect { transaction.save! }.to raise_error ActiveRecord::RecordInvalid
  end

  it 'can\'t have date without administrator' do
    transaction.managed_at = DateTime.now
    expect{ transaction.save!}.to raise_error ActiveRecord::RecordInvalid
  end

end
