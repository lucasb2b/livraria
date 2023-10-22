class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = Account.all
  end

  def show
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)

    if @account.save
      flash[:success] = "Conta cadastrada"
      redirect_to dashboard_account_path
    else
      flash[:error] = "Erro ao processar a solicitação"
      redirect_to dashboard_account_path
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update(book_params)
      flash[:notice] = "Dados da conta atualizados com sucesso!"
      redirect_to dashboard_account_path
    else
      flash[:error] = "Houve um erro ao processar a solicitação!"
      redirect_to dashboard_account_path
    end
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    flash[:notice] = "Conta apagada com sucesso."
    redirect_to dashboard_account_path
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:supplier_id, :account_number, :verify_number)
  end
end
