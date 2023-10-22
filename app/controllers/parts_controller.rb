class PartsController < ApplicationController
  before_action :set_part, only: [:show, :edit, :update, :destroy]

  def index
    @parts = Part.all
  end

  def show

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
    @part = Part.find(params[:id])
    @part.destroy
    params[:id] = nil
    flash[:notice] = "Peça apagada com sucesso!"
    redirect_to dashboard_part_path
  end

  private

  def set_part
    @part = Part.find(params[:id])
  end

  def part_params
    params.require(:part).permit(:part_number, :name)
  end

end
