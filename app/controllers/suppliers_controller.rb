class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  def index
    @suppliers = Supplier.all
    @user = current_user
  end
  def show
  end
  def new
    @supplier = Supplier.new
  end
  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save
      flash[:success] = "Empresa cadastrada com sucesso!"
      redirect_to dashboard_supplier_path
    else
      flash[:error] = "Houve um erro ao processar a solicitação"
      redirect_to dashboard_supplier_path
    end
  end
  def edit
    @supplier = Supplier.find(params[:id])
    @user = current_user
  end
  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update(supplier_params)
      flash[:notice] = "Os dados da empresa foram atualizados com sucesso!"
      redirect_to dashboard_supplier_path
    else
      flash[:error] = "Houve um erro ao processar a solicitação!"
      redirect_to dashboard_supplier_path
    end
  end
  def destroy
    selected_ids = params[:selected_ids]
    errors = []

    puts selected_ids

    # Itera sobre os IDs e tenta excluir cada autor
    selected_ids.each do |id|
      supplier = Supplier.find_by(id: id)

      if supplier && supplier.account.any?
        errors << "Fornecedor '#{supplier.name}' tem contas vínculadas e não pode ser excluída."
      elsif supplier
        supplier.destroy
      else
        errors << "Fornecedor com ID '#{id}' não encontrado."
      end
    end

    if errors.any?
      render json: {errors: errors}, status: :unprocessable_entity
    else
      render json: {message: 'Registros excluídos com sucesso!'}, status: :ok
    end
  end

  def new_destroy
    selected_ids = params[:selected_ids]
    errors = []

    # Converte os IDs para um array de inteiros para problemas de segurança
    selected_ids = selected_ids.map(&:to_i)

    # Itera sobre os IDs e tenta excluir cada fornecedor
    selected_ids.each do |id|
      supplier = Supplier.find_by(id: id)

      # Verifica se o fornecedor existe
      if supplier
        # Verifica se há contas vinculadas ao fornecedor
        if supplier.account.present?
          errors << "Fornecedor '#{supplier.name}' tem contas vinculadas e não pode ser excluído"
        else
          supplier.destroy
        end
      else
        errors << "Fornecedor com ID '#{id}' não encontrado."
      end
    end

    if errors.any?
      render json: {errors: errors}, status: :unprocessable_entity
    else
      render json: {message: 'Registros excluídos com sucesso!'}, status: :ok
    end
  end

  private
  def set_supplier
    @supplier = Supplier.find(params[:id])
  end
  def supplier_params
    params.require(:supplier).permit(:name, :cnpj)
  end
end
