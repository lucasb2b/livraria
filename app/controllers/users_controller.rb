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

# Vamos ver o que pode ser feito neste código
# Toda vez vejo no que eu me meti ao fazer isso
# mas é a vida né
# Meu wakatime está marcando 58 minutos agora e estou escrevendo isso apenas para
# passar o tempo já que faltam apenas dois minutos para completar uma hora de código continua
# isso sem contar as pausas e como já irá bater 23 horas quero logo acabar com isso
# para poder desligar o computador e ir dormir e sei lá, talvez assistir algum anime
# estou carente de anime desde que dragon ball super acabou em 2018
# era o meu passatempo favorito acordar domingo de manhã e ver as aventuras de Goku e seus amigos
# Mas agora ando muito sem tempo para fazer isso então sinto muito a todos vocês
# mas isso é a vida, crescer e obter responsbilidades das quais você não pediu
# estou me esforçando para ficar acordado ouvindo city pop da Tomoko Aran
