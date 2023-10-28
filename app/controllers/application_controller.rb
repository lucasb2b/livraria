class ApplicationController < ActionController::Base

  def require_login
    unless logged_in?
      flash[:danger] = "Você precisa estar logado para acessar esta página."
      redirect_to new_session_path
    end
  end

  private
  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
