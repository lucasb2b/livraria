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

  def manage
    @user = current_user
    @assemblies = Assembly.all
    @parts = Part.all
  end

  def assembly_assembly
    selected_assembly = Assembly.find(params[:id].to_i)
    parts = selected_assembly.parts
    render json: parts
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
    @user = current_user
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
    #assembly = Assembly.where(id: params[:assembly][:ttt])
    @part = Part.where(id: params[:assembly][:cu])

    @assembly = Assembly.find(params[:assembly][:ttt])
    @parts = @assembly.parts

    @assembly.parts << @part
    flash[:success] = 'ok'
    redirect_to dashboard_assembly_path
  end

  def associate_assemblies
    @assemblies = Assembly.all
    @user = current_user
  end

  def destroy_part
    part_id = params[:id]
    assembly_id = params[:assembly_id]

    assembly = Assembly.find_by(id: assembly_id)
    part = Part.find_by(id: part_id)

    if assembly.parts.include?(part)
      assembly.parts.delete(part)
      render json: { message: "Registro apagado com sucesso!"}, status: :ok
    else
      render json: { message: "Houve um erro"}, status: :unprocessable_entity
    end
  end

  def destroy_assembly
    selected_ids = params[:selected_ids]
    errors = []

    assemblies = Assembly.where(id: selected_ids)

    assemblies.each do |assembly|
      if assembly.parts.count != 0
        errors << "Montagem '#{assembly.name}' tem peças vinculadas e não pode ser apagada"
      else
        assembly.destroy
      end
    end

    if errors.any?
      render json: { errors: errors }, status: :unprocessable_entity
    else
      render json: { message: 'Montagens apagadas com sucesso!' }, status: :ok
    end
  end


  private


  def assembly_params
    params.require(:assembly).permit(:id, :name)
  end

  def set_assembly
    @assembly = Assembly.find(params[:id])
  end
end
