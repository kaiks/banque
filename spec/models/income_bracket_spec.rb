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
end
