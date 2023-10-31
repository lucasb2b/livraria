class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  def index
    @authors = Author.all
    @user = current_user
  end
  def show
    @author = Author.find(params[:id])
  end
  def new
    @author = Author.new
  end
  def edit
    @author = Author.find(params[:id])
    @user = current_user
  end
  def update
    @user = current_user
    @author = Author.find(params[:id])
    if @author.update(author_params)
      redirect_to show_authors_path, notice: "Os dados do autor foram atualizados com sucesso!"
    else
      flash[:error] = "Houve um erro ao processar a solicitação!"
      redirect_to show_authors_path
    end
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
    selected_ids = params[:selected_ids]
    # Itera sobre os IDs e exclui cada registro
    selected_ids.each do |id|
      author = Author.find(id)
      count = Author.find(id).books.count
      if count > 0
        flash[:error] = "Este autor contém livros cadastrados! Exclua os livros do autor primeiro!"
        redirect_to show_authors_path
      else
        author.destroy
        flash[:success] = "Autor excluído com sucesso!"
        redirect_to show_authors_path
      end
    end
  end

  def custom_destroy
    selected_ids = params[:selected_ids]
    errors = []

    # Itera sobre os IDs e tenta excluir cada autor
    selected_ids.each do |id|
      author = Author.find_by(id: id)

      if author && author.books.any?
        errors << "Autor '#{author.name}' tem livros vinculados e não pode ser excluído."
      elsif author
        author.destroy
      else
        errors << "Autor com ID '#{id}' não encontrado."
      end
    end

    if errors.any?
      render json: {errors: errors}, status: :unprocessable_entity
    else
      render json: {message: 'Registros excluídos com sucesso!'}, status: :ok
    end
  end

  private

  def author_params
    params.require(:author).permit(:name, :cpf)
  end

  def set_author
    @author = Author.find(params[:id])
  end
end
