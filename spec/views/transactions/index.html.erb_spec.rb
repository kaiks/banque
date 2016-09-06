require 'rails_helper'

RSpec.describe "transactions/index", type: :view do
  before(:each) do
    assign(:transactions, [
      Transaction.create!(
        :account_id => 2,
        :type => 3,
        :status => 4,
        :accepted_by => 5
      ),
      Transaction.create!(
        :account_id => 2,
        :type => 3,
        :status => 4,
        :accepted_by => 5
      )
    ])
  end

  it "renders a list of transactions" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
