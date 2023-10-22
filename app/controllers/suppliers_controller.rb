class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  def index
    @suppliers = Supplier.all
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
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    params[:id] = nil
    flash[:notice] = "Empresa foi apagada com sucesso."
    redirect_to dashboard_supplier_path
  end

  private
  def set_supplier
    @supplier = Supplier.find(params[:id])
  end
  def supplier_params
    params.require(:supplier).permit(:name, :cnpj)
  end
end
