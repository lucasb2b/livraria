class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def change_password
    @user = User.find_by(id: current_user.id)
    new_password = params[:password_confirmation]
    confirmation_password = params[:password_confirmation_confirmation]

    if @user
      if @user.authenticate(params[:user][:password])
        if new_password == confirmation_password
          params[:user][:password] = confirmation_password
          if @user.update(user_params)
            flash[:success] = "Senha alterada com sucesso"
            redirect_to dashboard_path
          else
            flash[:error] = "Erro ao trocar a senha"
            redirect_to dashboard_path
          end
        else
          flash[:error] = "Não foi possível alterar a senha"
        end
      else
        flash[:error] = "Não foi possível alterar a senha"
      end
    else
      flash[:error] = "Não foi possível alterar a senha"
    end
  end

  def create_async
    user = User.create

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
