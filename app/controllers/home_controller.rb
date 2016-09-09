class HomeController < ApplicationController
  def index
    attempt_login
    @user ||= User.new
  end

  def dashboard
    redirect_to action: 'index' unless login_success?
  end

  def attempt_login
    redirect_to action: 'dashboard' if login_success?
  end

  private
  def login_success?
    if session.fetch(:user_id, 0) > 0
      @user ||= User.find(session[:user_id])
      true
    else
      false
    end
  end
end
