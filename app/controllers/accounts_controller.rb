class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = Account.all
    @user = current_user
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
    @user = current_user
  end

  def update
    @account = Account.find(params[:id])
    if @account.update(account_params)
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

  def destroy_ajax
    selected_ids = params[:selected_ids]
    # Itera sobre os IDs e exclui cada registro
    selected_ids.each do |id|
      account = Account.find(id)
      account.destroy
    end
    render json: {message: 'Registro excluído com sucesso'}, status: :ok
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:supplier_id, :account_number, :verify_number)
  end
end
