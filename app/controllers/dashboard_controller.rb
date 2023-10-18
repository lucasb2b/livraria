class DashboardController < ApplicationController
  before_action :require_login

  def show
    render 'dashboard'
  end

  private

  def require_login
    unless logged_in?
      flash[:danger] = "Você precisa estar logado para acessar esta página."
      redirect_to new_session_path
    end
  end
end
