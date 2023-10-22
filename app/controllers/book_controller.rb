class BookController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
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
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Os dados do livro foram atualizados com sucesso!"
      redirect_to dashboard_book_path
    else
      flash[:error] = "Houve um erro ao processar a solicitação!"
      redirect_to dashboard_book_path
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    params[:id] = nil
    flash[:notice] = "O livro foi apagado com sucesso."
    redirect_to dashboard_book_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:author_id, :published_at, :isbn, :title)
  end
end
