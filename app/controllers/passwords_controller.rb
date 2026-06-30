# Controller responsável pela definição e atualização de senhas de usuários.
# :reek:InstanceVariableAssumption
class PasswordsController < ApplicationController
  skip_before_action :require_login, only: %i[edit update]

  # GET /passwords/:user_id/edit
  def edit
    @user = User.find(params[:user_id])
  end

  # PATCH/PUT /passwords/:user_id
  def update
    @user = User.find(params[:user_id])

    if password_valid?
      activate_user_and_redirect
    else
      handle_invalid_password
    end
  end

  private

  # Isola a lógica condicional (C do ABC Score)
  def password_valid?
    password = params[:password].to_s
    password.length >= 8 && password == params[:password_confirmation]
  end

  # Isola a persistência e redirecionamento (A e B do ABC Score)
  def activate_user_and_redirect
    @user.update!(status: 'ativo', password: params[:password])
    redirect_to new_session_path, notice: "Cadastro ativado com sucesso"
  end

  # Isola o fluxo de falha na renderização
  def handle_invalid_password
    flash.now[:alert] = "A senha deve conter no mínimo 8 caracteres e coincidir com a confirmação"
    render :edit, status: :unprocessable_entity
  end
end