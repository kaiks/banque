RSpec.shared_context 'shared stuff', :shared_context => :metadata do
  let(:bracket)     { create :income_bracket }
  let(:user)        { build :user, income_bracket: bracket }
  let(:account)     { build :account, user: user }
  let(:transaction) { build :transaction, account: account }
  let(:admin)       { create :admin}
 end