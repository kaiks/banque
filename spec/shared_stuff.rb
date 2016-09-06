RSpec.shared_context 'shared stuff', :shared_context => :metadata do
  let(:bracket)     { FactoryGirl.create :income_bracket }
  let(:user)        { FactoryGirl.create :user, income_bracket: bracket }
  let(:account)     { FactoryGirl.create :account, user: user }
  let(:transaction) { FactoryGirl.create :transaction, account: account }
  let(:admin)       { FactoryGirl.create :admin}
 end