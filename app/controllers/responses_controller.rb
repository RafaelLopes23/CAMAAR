# Controller responsável por gerenciar o ciclo de vida de Respostas/Avaliações.
# :reek:InstanceVariableAssumption
class ResponsesController < ApplicationController
  before_action :set_response, only: %i[ show edit update destroy ]

  # Lista todas as respostas cadastradas.
  #
  # @return [void]
  # @note Carrega os registros em `@responses`.
  def index
    @responses = Response.all
  end

  # Exibe uma resposta especifica.
  #
  # @return [void]
  # @note Utiliza `@response`, definido pelo callback `set_response`.
  def show
  end

  # Prepara uma nova resposta para preenchimento.
  #
  # @return [void]
  # @note Instancia `@response` sem persistencia.
  def new
    @response = Response.new
  end

  # Carrega uma resposta existente para edicao.
  #
  # @return [void]
  # @note Utiliza `@response`, definido pelo callback `set_response`.
  def edit
  end

  # Cria uma nova resposta com os parametros recebidos.
  #
  # @return [void]
  # @note Persiste a resposta quando valida e redireciona para o detalhe.
  def create
    @response = Response.new(response_params)
    saved = @response.save

    respond_to do |format|
      dispatch_response_result(format, saved, :new, @response, "Avaliação enviada com sucesso", :created)
    end
  end

  # Atualiza uma resposta ja existente.
  #
  # @return [void]
  # @note Persiste as alteracoes quando os dados sao validos.
  def update
    updated = @response.update(response_params)

    respond_to do |format|
      dispatch_response_result(format, updated, :edit, @response, "Response was successfully updated.", :ok)
    end
  end

  # Remove uma resposta persistida.
  #
  # @return [void]
  # @note Exclui o registro do banco e redireciona para a listagem.
  def destroy
    @response.destroy!

    respond_to do |format|
      format.html { redirect_to responses_path, notice: "Response was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  # Busca a resposta referenciada pelo parametro `id`.
  #
  # @return [void]
  # @raise [ActiveRecord::RecordNotFound] quando a resposta nao existir.
  def set_response
    @response = Response.find(params[:id])
  end

  # Filtra os parametros permitidos para a resposta.
  #
  # @return [ActionController::Parameters] parametros seguros da resposta.
  # @note Aceita `form_id`, `user_id` e `content`.
  def response_params
    params.expect(response: [ :form_id, :user_id, :content ])
  end

  # Centraliza a resposta HTML e JSON das acoes de criacao e atualizacao.
  #
  # @param format [ActionController::MimeResponds::Collector] coletor de formatos da acao.
  # @param success [Boolean] resultado da operacao de persistencia.
  # @param action_view [Symbol] view renderizada em caso de falha.
  # @param resource [Response] resposta processada na acao.
  # @param message [String] mensagem exibida em caso de sucesso.
  # @param success_status [Symbol] status HTTP usado na resposta JSON.
  # @return [void]
  # @note Pode redirecionar ou renderizar uma view sem nova escrita no banco.
  def dispatch_response_result(format, success, action_view, resource, message, success_status)
    if success
      format.html { redirect_to resource, notice: message, status: (success_status == :ok ? :see_other : :found) }
      format.json { render :show, status: success_status, location: resource }
    else
      format.html { render action_view, status: :unprocessable_content }
      format.json { render json: resource.errors, status: :unprocessable_content }
    end
  end
end
