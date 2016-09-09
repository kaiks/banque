class HomeController < ApplicationController
  def index
    @user = User.new
  end

  def dashboard
    puts "dank memes #{session[:user_id]}"
    if session.fetch(:user_id, 0) > 0
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end
end
