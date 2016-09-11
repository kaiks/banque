class HomeController < ApplicationController
  before_action :ensure_user_authenticated, only: :dashboard

  def index
    attempt_login
    @current_user ||= User.new
  end

  def dashboard
    redirect_to action: 'index' unless login_success?
    @accounts = @current_user.accounts
    @positive_accounts = @accounts.where('balance > 0')
    @total_cash = @accounts.sum(:balance)
    @recent_transactions = @current_user.transactions.last(5)

  end

  def attempt_login
    redirect_to action: 'dashboard' if login_success?
  end

  def setup_chart

  end

end
