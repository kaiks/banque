class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def login_success?
    if session.fetch(:user_id, 0) > 0
      @current_user ||= User.find(session[:user_id])
      true
    else
      false
    end
  end
end
