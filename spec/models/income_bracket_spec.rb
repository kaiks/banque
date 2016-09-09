require 'rails_helper'

RSpec.describe IncomeBracket, type: :model do
  let(:bracket) { build :income_bracket }
  it 'does not allow intersecting' do
    other_bracket = create :income_bracket, min: 555, max: 1500
    expect(bracket).to be_invalid
  end

  it 'must have min' do
    bracket.min = nil
    expect(bracket).to be_invalid
  end

  it 'must have max' do
    bracket.max = nil
    expect(bracket).to be_invalid
  end

  it 'must have positive range' do
    bracket.min = 1500
    expect(bracket).to be_invalid
  end

  it 'must have positive minimum' do
    bracket.min = -1
    expect(bracket).to be_invalid
  end

  context 'negative max' do
    it 'can be -1' do
      open_bracket = build :open_bracket
      expect(open_bracket).to be_valid
    end

    it 'cant be other than -1' do
      open_bracket = build :open_bracket, max: -2
      expect(open_bracket).to be_invalid
    end
  end

  describe '.to_s' do
    it 'returns the bracket range' do
      expect(bracket.to_s).to eq '0 - 999'
    end
    it 'returns the open bracket range' do
      open_bracket = build :open_bracket
      expect(open_bracket.to_s).to eq '1000 ou plus'
    end
  end

end
