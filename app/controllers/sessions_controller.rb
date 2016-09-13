class SessionsController < ApplicationController
  def new
    user = User.authenticates?(params[:id], params[:password])
    if user
      session[:user_id] = user.id
      @current_user = User.find_by_id(session[:user_id])
      redirect_to dashboard_url
    else
      redirect_to(root_url, alert: "Mot de pass n'est pas valide.")
    end
  end

  def login_admin
    admin = Admin.authenticates?(params[:admin][:username], params[:admin][:password])
    if admin
      session[:admin_id] = admin.id
      redirect_to admins_url
    else
      flash.keep
      redirect_to(admins_login_url, alert: "Mot de pass n'est pas valide.")
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def admin_destroy
    session[:admin_id] = nil
    redirect_to root_url
  end
end
