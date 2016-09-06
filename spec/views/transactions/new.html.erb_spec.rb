require 'rails_helper'

RSpec.describe "transactions/new", type: :view do
  before(:each) do
    assign(:transaction, Transaction.new(
      :account_id => 1,
      :type => 1,
      :status => 1,
      :accepted_by => 1
    ))
  end

  it "renders new transaction form" do
    render

    assert_select "form[action=?][method=?]", transactions_path, "post" do

      assert_select "input#transaction_account_id[name=?]", "transaction[account_id]"

      assert_select "input#transaction_type[name=?]", "transaction[type]"

      assert_select "input#transaction_status[name=?]", "transaction[status]"

      assert_select "input#transaction_accepted_by[name=?]", "transaction[accepted_by]"
    end
  end
end
