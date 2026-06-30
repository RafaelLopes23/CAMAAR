# Controller responsavel pelo ciclo de vida dos formularios de avaliacao.
class FormsController < ApplicationController
  before_action :set_form, only: %i[ show edit update destroy ]

  # Lista todos os formularios cadastrados.
  #
  # @return [void]
  # @note Carrega os registros em `@forms` para a view.
  def index
    @forms = Form.all
  end

  # Exibe um formulario especifico.
  #
  # @return [void]
  # @note Utiliza `@form`, definido pelo callback `set_form`.
  def show
  end

  # Prepara um novo formulario para preenchimento.
  #
  # @return [void]
  # @note Instancia `@form` sem persistir no banco.
  def new
    @form = Form.new
  end

  # Carrega um formulario existente para edicao.
  #
  # @return [void]
  # @note Utiliza `@form`, definido pelo callback `set_form`.
  def edit
  end

  # Cria um novo formulario com os parametros enviados.
  #
  # @return [void]
  # @note Persiste o formulario quando os dados sao validos.
  def create
    @form = Form.new(form_params)
    respond_with_form_result(@form.save, :new, @form, "Formulário disponibilizado com sucesso", :created)
  end

  # Atualiza um formulario existente.
  #
  # @return [void]
  # @note Persiste as alteracoes quando os dados sao validos.
  def update
    respond_with_form_result(@form.update(form_params), :edit, @form, "Form was successfully updated.", :ok)
  end

  # Remove um formulario existente.
  #
  # @return [void]
  # @note Exclui o registro e redireciona para a listagem.
  def destroy
    @form.destroy!

    respond_to do |format|
      format.html { redirect_to forms_path, notice: "Form was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  # Busca o formulario referenciado pelo parametro `id`.
  #
  # @return [void]
  # @raise [ActiveRecord::RecordNotFound] quando o formulario nao existir.
  def set_form
    @form = Form.find(params.expect(:id))
  end

  # Filtra os parametros permitidos para criacao e atualizacao.
  #
  # @return [ActionController::Parameters] parametros seguros do formulario.
  # @note Aceita apenas `title` e `template_id`.
  def form_params
    params.expect(form: [ :title, :template_id ])
  end

  # Centraliza as respostas HTTP das acoes de criacao e atualizacao.
  #
  # @param success [Boolean] resultado da operacao de persistencia.
  # @param action_view [Symbol] view renderizada em caso de falha.
  # @param form [Form] formulario processado pela acao.
  # @param notice_message [String] mensagem exibida em caso de sucesso.
  # @param success_status [Symbol] status HTTP usado na resposta JSON.
  # @return [void]
  # @note Pode redirecionar ou renderizar uma view sem nova escrita no banco.
  def respond_with_form_result(success, action_view, form, notice_message, success_status)
    respond_to do |format|
      if success
        format.html { redirect_to form, notice: notice_message, status: redirect_status_for(success_status) }
        format.json { render :show, status: success_status, location: form }
      else
        format.html { render action_view, status: :unprocessable_content }
        format.json { render json: form.errors, status: :unprocessable_content }
      end
    end
  end

  # Define o status do redirecionamento HTML para operacoes bem-sucedidas.
  #
  # @param success_status [Symbol] status HTTP da resposta JSON.
  # @return [Symbol] `:found` para criacao e `:see_other` para atualizacao.
  # @note Nao possui efeitos colaterais.
  def redirect_status_for(success_status)
    success_status == :ok ? :see_other : :found
  end
end
