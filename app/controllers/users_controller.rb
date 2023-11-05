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

    logger.debug "Params: #{params.inspect}"

    if @user
      puts "Usuario existe"
      if @user.authenticate(params[:user][:password])
        puts "Fez login"
        if new_password == confirmation_password
          puts "As senhas são iguais"
          puts "Pode trocar a senha"
          params[:user][:password] = confirmation_password
          if @user.update(user_params)
            logger.debug "Senha alterada com sucesso"
            flash[:success] = "Senha alterada com sucesso"
            redirect_to dashboard_path
          else
            logger.debug "Erro ao trocar a senha"
            flash[:error] = "Erro ao trocar a senha"
            redirect_to dashboard_path
          end
        else
          puts "As senhas não são iguais"
          puts new_password
          puts "----------------------------------------------------------------------"
          puts confirmation_password
        end
      else
        puts "Usuário ou senha incorreto"
      end
    else
      puts "usuario não existe"
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
