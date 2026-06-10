class PasswordsController < ApplicationController
  skip_before_action :require_login, only: %i[edit update]

  def edit
    @user = User.find(params[:user_id])
  end

  def update
    @user = User.find(params[:user_id])
    if params[:password].length >= 8 && params[:password] == params[:password_confirmation]
      @user.update!(status: 'ativo')
      redirect_to new_session_path, notice: "Cadastro ativado com sucesso"
    else
      flash.now[:alert] = "A senha deve conter no mínimo 8 caracteres"
      render :edit, status: :unprocessable_entity
    end
  end
end
