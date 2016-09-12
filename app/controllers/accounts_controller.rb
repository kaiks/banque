class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy, :print_rib]

  before_action :ensure_user_or_admin_authenticated, only: [:new, :show, :index, :destroy, :print_rib]
  before_action :ensure_correct_user, only: [:show, :destroy, :print_rib]
  before_action :ensure_admin_authenticated,
                only: [:edit, :update, :destroy, :activate, :close]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = @current_user.accounts.order(id: :desc).page(params[:page]).per(10)
  end

  def recent
    @accounts = Account.order(id: :desc).page(params[:page]).per(10)
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @transactions = @account.transactions.order(id: :desc).page(params[:page]).per(10)
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new
    @account.user_id = session[:user_id]

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Compte à été créé.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Compte mis à jour.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    redirect_to account_url(@account), alert: 'On ne peut pas supprimer ce compte' unless @account.deletable?
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Compte detruit.' }
      format.json { head :no_content }
    end
  end

  def activate
    id = params[:id]
    a = Account.find(id)
    a.active!

    redirect_to request.referer, notice: 'Compte activé'
  end

  def close
    id = params[:id]
    a = Account.find(id)
    a.closed!

    redirect_to request.referer, notice: 'Compte fermé'
  end

  def print_rib
    @account = Account.find(params[:id])
    @rib = @account.rib
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit()
  end

    # Only allow for status changes.
  def account_admin_params
    params.require(:account).permit(:status)
  end

  def ensure_correct_user
    sid = session[:user_id] || -1
    return if session[:admin_id] || sid == @account.user.id
    redirect_to request.referer, alert: 'Opération ne peut pas être effectuée pour cet utilisateur.'
  end
end
