# Controller responsável pela definição e atualização de senhas de usuários.
# :reek:InstanceVariableAssumption
class PasswordsController < ApplicationController
  skip_before_action :require_login, only: %i[edit update]

  # Exibe o formulario de definicao de senha para o usuario informado.
  #
  # @return [void]
  # @note Carrega `@user` a partir de `params[:user_id]`.
  def edit
    @user = User.find(params[:user_id])
  end

  # Atualiza a senha do usuario e ativa seu cadastro quando os dados sao validos.
  #
  # @return [void]
  # @note Pode atualizar o banco e redirecionar para a tela de login.
  def update
    @user = User.find(params[:user_id])

    if password_valid?
      activate_user_and_redirect
    else
      handle_invalid_password
    end
  end

  private

  # Verifica se a senha enviada atende as regras minimas da aplicacao.
  #
  # @return [Boolean] `true` quando a senha possui ao menos 8 caracteres
  #   e coincide com a confirmacao.
  # @note Nao persiste dados.
  def password_valid?
    password = params[:password].to_s
    password.length >= 8 && password == params[:password_confirmation]
  end

  # Ativa o usuario e salva a nova senha informada.
  #
  # @return [void]
  # @note Atualiza `status` e `password` no banco e redireciona para login.
  def activate_user_and_redirect
    @user.update!(status: "ativo", password: params[:password])
    redirect_to new_session_path, notice: "Cadastro ativado com sucesso"
  end

  # Trata a falha de validacao da senha mantendo o usuario na tela de edicao.
  #
  # @return [void]
  # @note Nao altera o banco e renderiza `:edit` com status 422.
  def handle_invalid_password
    flash.now[:alert] = "A senha deve conter no mínimo 8 caracteres e coincidir com a confirmação"
    render :edit, status: :unprocessable_entity
  end
end
