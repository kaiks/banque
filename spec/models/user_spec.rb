require "rails_helper"

RSpec.describe User, :type => :model do
  it "cannot have nulls" do
    expect {
      User.create!(name: "Jacques", surname: "Dupont")
    }.to raise_error ActiveRecord::RecordInvalid
  end
end