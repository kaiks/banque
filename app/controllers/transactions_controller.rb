class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy]

  before_action :ensure_user_or_admin_authenticated, only: [:show]
  before_action :ensure_admin_authenticated,
                only: [:edit, :update, :destroy, :waiting, :accept, :reject,
            :new, :create, :index]
  before_action :ensure_correct_user, only: [:show]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.order(id: :desc).page(params[:page]).per(10)
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction  = Transaction.new
    @accounts     = Account.all
  end

  # GET /transactions/1/edit
  def edit
    show
  end

  #todo
  def waiting
    @transactions = Transaction.where(status: 'waiting')
  end


  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction a été créée.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction a été mise à jour.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction à été supprimée.' }
      format.json { head :no_content }
    end
  end

  def accept
    id = params[:id]
    t = Transaction.find(id)
    t.managed_by = session[:admin_id]
    t.managed_at = DateTime.now
    t.accepted!

    redirect_to request.referer, notice: 'Transaction accepteé'
  end

  def refuse
    id = params[:id]
    t = Transaction.find(id)
    t.managed_by = session[:admin_id]
    t.managed_at = DateTime.now
    t.refused!

    redirect_to request.referer, notice: 'Transaction refusée'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find_by_id(params[:id])
      redirect_to transactions_url, flash: {error: 'Transaction n\'existe pas'} unless @transaction
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:account_id, :amount, :transaction_type)
    end

    def transaction_admin_params
      params.require(:transaction).permit(:account_id, :amount, :transaction_type, :status, :managed_by)
    end

  def ensure_correct_user
    sid = session[:user_id] || -1
    return if session[:admin_id] || sid == @transaction.user.id
    redirect_to request.referer, alert: 'Opération ne peut pas être effectuée pour cet utilisateur.'
  end
end
