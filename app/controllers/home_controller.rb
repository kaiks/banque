class HomeController < ApplicationController
  def index
    attempt_login
    @current_user ||= User.new
  end

  def dashboard
    redirect_to action: 'index' unless login_success?
    @accounts = @current_user.accounts
    @recent_transactions = @current_user.transactions.last(5)
  end

  def attempt_login
    redirect_to action: 'dashboard' if login_success?
  end


end
