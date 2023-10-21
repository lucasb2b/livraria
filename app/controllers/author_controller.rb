class AuthorController < ApplicationController
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
    author.save
    redirect_to dashboard_author_path
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
