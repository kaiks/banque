class TransactionsController < ApplicationController
  before_action :ensure_user_authenticated, only: [:show]
  before_action :ensure_admin_authenticated,
                only: [:edit, :update, :destroy, :waiting, :accept, :reject,
                       :new, :create]
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

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
    @accounts     = @current_user.accounts
    puts "accounts: #{@accounts.map{|a|a.rib}.join(' ')}"
  end

  # GET /transactions/1/edit
  def edit
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
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
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
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
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
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def accept
    id = params[:id]
    t = Transaction.find(id)
    t.managed_by = session[:admin_id]
    t.managed_at = DateTime.now
    t.accepted!

    redirect_to request.referer, notice: 'Transaction accepted'
  end

  def refuse
    id = params[:id]
    t = Transaction.find(id)
    t.managed_by = session[:admin_id]
    t.managed_at = DateTime.now
    t.refused!

    redirect_to request.referer, notice: 'Transaction rejected'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:account_id, :amount, :transaction_type)
    end

    def transaction_admin_params
      params.require(:transaction).permit(:account_id, :amount, :transaction_type, :status, :managed_by)
    end
end
