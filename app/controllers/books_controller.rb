class BooksController < ApplicationController
  before_action :require_login, :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
    @user = current_user
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      flash[:success] = "Livro cadastrado com sucesso"
      redirect_to dashboard_book_path
    else
      flash[:error] = "Erro ao processar a solicitação"
      redirect_to dashboard_book_path
    end
  end

  def edit
    @book = Book.find(params[:id])
    @user = current_user
  end

  def update
    @user = current_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Os dados do livro foram atualizados com sucesso!"
      redirect_to dashboard_book_path
    else
      flash[:error] = "Houve um erro ao processar a solicitação!"
      redirect_to dashboard_book_path
    end
  end

  def assembly
    @book = Book.find(params[:id])
    @user = current_user

  end

  def join_to_assembly
    @book = Book.find(params[:book][:id])
    assembly_ids = Array(params[:book][:assembly_ids])

    # Remove IDs já associados ao livro
    assembly_ids.reject! { |id| @book.assembly_ids.include?(id.to_i) }

    # Adiciona os novos IDs ao livro
    @book.assembly_ids += assembly_ids.map(&:to_i)

    if @book.save
      flash[:success] = "Livro associado às montagens com sucesso"
      redirect_to assembly_books_path(@book)
    else
      render :'assemblies/manage'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    params[:id] = nil
    flash[:notice] = "O livro foi apagado com sucesso."
    redirect_to dashboard_book_path
  end

  def destroy_multiple
    selected_ids = params[:selected_ids]
    # Itera sobre os IDs e exclui cada registro
    selected_ids.each do |id|
      book = Book.find(id)
      book.destroy
    end
    render json: { message: 'Registro excluídos com sucesso' }, status: :ok
  end

  def destroy_assembly_by_book
    assembly_id = params[:assembly_id]
    book_id = params[:book_id]

    # Encontrar e excluir o registro da tabela intermediária
    book_assembly = BookAssembly.find_by(assembly_id: assembly_id, book_id: book_id)
    book_assembly.destroy if book_assembly

    # Responder com sucesso
    head :no_content
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:author_id, :published_at, :isbn, :title)
  end

end
