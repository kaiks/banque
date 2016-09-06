require 'rails_helper'
require_relative '../shared_stuff.rb'

RSpec.describe Account, type: :model do
  include_context 'shared stuff'

  context '.rib' do
    it 'joins bank code, sort code, number and key' do
      expect(account.rib).to eq('0000100678A1B2C3D4E5044')
    end
  end
end
