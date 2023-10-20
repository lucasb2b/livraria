class AuthorController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  def index
    @authors = Author.all
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      redirect_to dashboard_author_path, notice: 'Autor salvo com sucesso.'
    else
      render dashboard_path
    end
  end

  private

  def set_author
    author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, :cpf)
  end
end
