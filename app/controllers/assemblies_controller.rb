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
    @part = Part.find(params[:part_id])
    @assembly = Assembly.new(assembly_params)

    if @assembly.save
      @assembly = Assembly.last
      if @assembly.parts << @part
        redirect_to dashboard_assembly_path, notice: "Peça vinculada a montagem!"
      else
        redirect_to dashboard_assembly_path, notice: "Erro ao vincular peça a montagem"
      end
    else
      flash[:error] = "Não foi possível completar a solicitação"
      redirect_to dashboard_assembly_path
    end
  end

  private

  def set_assembly
    @assembly = Assembly.find(params[:id])
  end

  def assembly_params
    params.require(:assembly).permit(:name)
  end
end
