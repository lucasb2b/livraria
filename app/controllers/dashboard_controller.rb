class DashboardController < ApplicationController
  before_action :require_login

  def show
    render 'dashboard'
    @user = current_user
  end
  def author
    render 'author'
  end
  def book
    render 'book'
  end
  def supplier
    render 'supplier'
  end
  def part
    render 'part'
  end
  def assembly
    render 'assembly'
  end


  private

  def require_login
    unless logged_in?
      flash[:danger] = "Você precisa estar logado para acessar esta página."
      redirect_to new_session_path
    end
  end
end
