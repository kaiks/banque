class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def ensure_user_or_admin_authenticated(return_to = root_url)
    redirect_to return_to unless (login_success? || admin_logged_in?)
  end

  def ensure_user_authenticated(return_to = root_url)
    redirect_to return_to unless login_success?
  end

  def ensure_admin_authenticated(return_to = root_url)
    redirect_to return_to unless admin_logged_in?
  end

  def login_success?
    if session.fetch(:user_id, 0) > 0
      @current_user ||= User.find(session[:user_id])
      true
    else
      false
    end
  end

  def admin_logged_in?
    if session.fetch(:admin_id, 0) > 0
      @current_admin ||= Admin.find(session[:admin_id])
      true
    else
      false
    end
  end

end
