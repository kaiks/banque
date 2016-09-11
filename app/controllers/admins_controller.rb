class AdminsController < ApplicationController
  before_action :ensure_admin_authenticated, except: :login

  def index
    @recent_transactions  = Transaction.last(10)
    @recent_accounts      = Account.last(10)
    @recent_users         = User.last(10)
  end

  def login
    @admin = Admin.new
  end

  def edit_transactions
  end

  def edit_accounts
  end

  def edit_user
  end

  def edit_user_transactions
  end

  def edit_user_accounts
  end
end
