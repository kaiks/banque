class SessionsController < ApplicationController
  def new
    user = User.authenticates?(params[:id], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to dashboard_url
    else
      redirect_to root_url, :alert => "Mot de pass n'est pas valid."
    end
  end

end
