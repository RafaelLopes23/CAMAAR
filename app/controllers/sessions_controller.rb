# Controller responsavel pela autenticacao e encerramento de sessao.
class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  skip_before_action :require_login, only: %i[new create]

  # Exibe a tela de login.
  #
  # @return [void]
  # @note Nao altera o estado da aplicacao.
  def new
  end

  # Autentica o usuario com email e senha.
  #
  # @return [void]
  # @note Define `session[:user_id]` em caso de sucesso ou renderiza erro em falha.
  def create
    user = User.authenticate(params[:email], params[:password])

    if user
      session[:user_id] = user.id
      redirect_to new_import_path, notice: "Login realizado com sucesso"
    else
      flash.now[:alert] = "Email ou senha inválidos"
      render :new, status: :unprocessable_entity
    end
  end

  # Encerra a sessao atual do usuario.
  #
  # @return [void]
  # @note Limpa `session[:user_id]` e redireciona para a tela de login.
  def destroy
    session[:user_id] = nil
    redirect_to new_session_path, notice: "Logout realizado com sucesso"
  end
end
