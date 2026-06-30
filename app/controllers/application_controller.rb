# Controller base da aplicacao, responsavel por autenticacao comum e helpers de sessao.
class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :require_login
  helper_method :current_user, :logged_in?

  private

  # Recupera o usuario autenticado na sessao atual.
  #
  # @return [User, nil] usuario encontrado para `session[:user_id]`, ou `nil`
  #   quando nao houver autenticacao ativa.
  # @note Memoiza o resultado em `@current_user` durante o request.
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Informa se existe um usuario autenticado no request atual.
  #
  # @return [Boolean] `true` quando `current_user` estiver presente.
  # @note Nao altera o estado da aplicacao.
  def logged_in?
    current_user.present?
  end

  # Restringe o acesso a rotas protegidas para usuarios autenticados.
  #
  # @return [void]
  # @note Redireciona para a tela de login quando a sessao estiver vazia.
  def require_login
    return if logged_in?

    redirect_to new_session_path, alert: "Por favor, faça login para continuar."
  end
end
