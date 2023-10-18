class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      reset_session
      session[:user_id] = user.id
      redirect_to dashboard_path, notice: "olá amigo!"
    else
      redirect_to sessions_path, alert: "Credenciais erradas"
    end
  end

  def destroy
    reset_session
    redirect_to new_session_path, alert: "Logout"
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
