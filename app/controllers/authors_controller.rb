class AuthorsController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @authors = Author.all
  end
  def show
    @author = Author.find(params[:id])
  end
  def new
    @author = Author.new
  end
  def edit
    @author = Author.find(params[:id])
  end
  def update
    author = Author.find(params[:id])
    author.update(author_params)

    redirect_to dashboard_author_path
  end
  def create
    author = Author.new(author_params)

    if author.save
      flash[:success] = "Autor cadastrado com sucesso!"
      redirect_to dashboard_author_path
    else
      flash[:error] = "Erro ao processar a solicitação!"
      redirect_to dashboard_author_path
    end
  end
  def destroy
    author = Author.find(params[:id])
    author.destroy
    redirect_to dashboard_author_path
  end

  private

  def author_params
    params.require(:author).permit(:name, :cpf)
  end
end
