RSpec.shared_context 'shared stuff', :shared_context => :metadata do
  let(:user)        { build :user }
  let(:account)     { build :account, user: user }
  let(:transaction) { build :transaction, account: account }
  let(:admin)       { create :admin}
 end