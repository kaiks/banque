class AdminsController < ApplicationController
  before_action :ensure_admin_authenticated, except: :login

  def index
    @recent_transactions  = Transaction.last(10)
    @recent_accounts      = Account.last(10)
    @recent_users         = User.last(10)

    @counters = {
        transactions: Transaction.waiting.count,
        users: User.count,
        accounts: Account.active.count
    }
  end

  def login
    @admin = Admin.new
  end
end
