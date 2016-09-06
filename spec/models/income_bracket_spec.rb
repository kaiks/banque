require 'rails_helper'

RSpec.describe IncomeBracket, type: :model do
  it "does not allow intersecting" do
    bracket = IncomeBracket.create! :min => 0, :max => 999
    expect{ IncomeBracket.create! :min => 555, :max => 1500 }.to raise_error ActiveRecord::RecordInvalid
  end
end
