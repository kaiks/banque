require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user)        { build :user }

  describe 'cannot take null value on' do
    it 'name' do
      user.name = nil
      expect(user).to be_invalid
    end
    it 'surname' do
      user.surname = nil
      expect(user).to be_invalid
    end
    it 'birth_date' do
      user.birth_date = nil
      expect(user).to be_invalid
    end
    it 'city' do
      user.city = nil
      expect(user).to be_invalid
    end
    it 'country' do
      user.country_code = nil
      expect(user).to be_invalid
    end
    it 'password' do
      user.password = nil
      expect(user).to be_invalid
    end
    it 'income_bracket' do
      user.income_bracket = nil
      expect(user).to be_invalid
    end
  end

  it 'doesnt accept 1 letter country codes' do
    user.country_code = 'F'
    expect(user).to be_invalid
  end

  it 'doesnt accept 3 letter country codes' do
    user.country_code = 'FRA'
    expect(user).to be_invalid
  end

  it 'passes validation with all fields' do
    expect(user).to be_valid
  end

  describe 'name_string' do
    it 'returns a printable name' do
      expect(user.full_name).to eq 'Jacques Dupont'
    end

    describe 'returns a printable name with title' do
      it 'for a male client' do
        expect(user.name_with_title).to eq 'Mr Jacques Dupont'
      end

      it 'for a female client' do
        mme_dupont = build(:user, :name => 'Madelaine', :title => :Mme)
        expect(mme_dupont.name_with_title).to eq 'Mme Madelaine Dupont'
      end

      it 'for a female non-married client' do
        mlle_dupont = build(:user, :name => 'Léa', :title => :Mlle)
        expect(mlle_dupont.name_with_title).to eq 'Mlle Léa Dupont'
      end
    end
  end
end