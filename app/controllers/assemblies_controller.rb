class AssembliesController < ApplicationController
  before_action :set_assembly, only: [:show, :edit, :update, :destroy]

  def index
    @assemblies = Assembly.all
  end

  def show
    @assembly = Assembly.find(params[:id])
    @parts = @assembly.parts
  end

  def new
    @assembly = Assembly.new
    @part = Part.new
  end

  def create
    @assembly = Assembly.new(assembly_params)

    if @assembly.save
      flash[:success] = "Montagem cadastrada com sucesso"
      redirect_to dashboard_assembly_path
    else
      flash[:error] = "Erro ao processar solicitação"
      redirect_to dashboard_assembly_path
    end
  end

  def edit
    @assembly = Assembly.find(params[:id])
  end

  def update
    @assembly = Assembly.find(params[:id])
    if @assembly.update(assembly_params)
      flash[:notice] = "Os dados da montagem foram atualizados com sucesso!"
      redirect_to dashboard_assembly_path
    else
      flash[:error] = "Houve um erro ao processar a solicitação!"
      redirect_to dashboard_assembly_path
    end
  end

  def destroy
    @assembly = Assembly.find(params[:id])
    @assembly.destroy
    params[:id] = nil
    flash[:notice] = "Montagem apagada com sucesso!"
    redirect_to dashboard_assembly_path
  end

  def assembly_part
    assembly = Assembly.where(id: params[:assembly][:ttt])
    part =

    if assembly.empty?
      puts "lucas"
    else
      puts assembly
    end

  end

  private


  def assembly_params
    params.require(:assembly).permit(:id, :name)
  end
end