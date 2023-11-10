class PartsController < ApplicationController
  before_action :set_part, only: [:show, :edit, :update, :destroy]

  def index
    @parts = Part.all.order(:id)
    @assemblies = Assembly.all
    @user = current_user
  end

  def show
    @part = Part.find(params[:id])
    @assemblies = @part.assemblies
  end

  def new
    @part = Part.new
  end

  def create
    @part = Part.new(part_params)

    if @part.save
      flash[:success] = "Peça cadastrada com sucesso!"
      redirect_to dashboard_part_path
    else
      flash[:error] = "Houve um erro ao processar a solicitação"
      redirect_to dashboard_part_path
    end
  end

  def edit
    @user = current_user
    @part = Part.find(params[:id])
  end

  def update
    @part = Part.find(params[:id])

    if @part.update(part_params)
      flash[:notice] = "Os dados foram atualizados com sucesso!"
      redirect_to dashboard_part_path
    else
      flash[:error] = "Houve um erro ao processar a solicitação!"
      redirect_to dashboard_part_path
    end
  end

  def destroy
    selected_ids = params[:selected_ids]

    selected_ids.each do |id|
      part = Part.find_by(id: id)
      if part.assemblies.empty?
        part.destroy
        flash[:success] = "Peça apagada com sucesso!"
        redirect_to create_part_path
      else
        flash[:error] = "Essa peça está inclusa em algumas montagens, primeiro tire da montagem"
        redirect_to create_part_path
      end
    end
  end

  def custom_destroy
    selected_ids = params[:selected_ids]
    errors = []

    #itera sobre os IDs de cada part e tenta excluir cada uma
    selected_ids.each do |id|
      part = Part.find_by(id: id)

      if part && part.assemblies.empty?
        part.destroy
      else
        errors << "A peça: ' #{part.name} ' não pode ser apagada pois está inserida em montagens."
      end
    end

    if errors.any?
      render json: {errors: errors}, status: :unprocessable_entity
    else
      render json: {message: 'Registros excluídos com sucesso!'}, status: :ok
    end
  end

  private

  def set_part
    @part = Part.find(params[:id])
  end

  def part_params
    params.require(:part).permit(:part_number, :name, :description, :price)
  end

end
