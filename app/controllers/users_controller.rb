class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_action :ensure_user_or_admin_authenticated, only: [:show, :edit, :update, :new, :create]
  before_action :ensure_admin_authenticated,
                only: [:index, :destroy, :waiting, :accept, :reject]
  before_action :ensure_correct_user, only: [:show, :edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    redirect_to @user, alert: 'Vous êtes déjà connecté' if session[:user_id]
    @user = User.new
    @brackets = IncomeBracket.all
  end

  # GET /users/1/edit
  def edit
    redirect_to user_path unless (admin_logged_in? || session[:user_id] == @user.id)
  end

  # POST /users
  # POST /users.json
  def create
    redirect_to @user, alert: 'Vous êtes déjà connecté' if session[:user_id]
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to dashboard_url,
            notice: "Compte d'utilisateur a été créé. Sauvegardez ID #{@user.id}!" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Compte d\'utilisateur a été mis à jour.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Utilisateur supprimé.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    if admin_logged_in?
      @user = User.find_by_id(params[:id]) || @current_user
      redirect_to(users_url, flash: {error: 'Utilisateur n\'existe pas'}) unless @user
    else
      @user = @current_user
    end
  end

  def ensure_correct_user(failure_redirect = nil)
    sid = session[:user_id] || -1
    return if session[:admin_id] || sid == @user.id

    failure_redirect_link ||= request.referer
    redirect_to failure_redirect_link, alert: 'Opération ne peut pas être effectuée pour cet utilisateur.'
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:title, :name, :surname, :birth_date, :city, :income_bracket_id, :password)
    end
end
