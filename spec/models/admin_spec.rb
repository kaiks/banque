require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:admin)        { build :admin }
  describe 'cannot take null value on' do
    it 'username' do
      admin.username = nil
      expect(admin).to be_invalid
    end
    it 'password' do
      admin.password = nil
      expect(admin).to be_invalid
    end
  end

  it 'passes with valid parameters' do
    expect(admin).to be_valid
  end

end
