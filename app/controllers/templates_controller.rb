# Controller responsável por gerenciar o ciclo de vida de Templates.
# :reek:InstanceVariableAssumption
class TemplatesController < ApplicationController
  before_action :set_template, only: %i[ show edit update destroy ]

  # Lista todos os templates cadastrados.
  #
  # @return [void]
  # @note Carrega os registros em `@templates`.
  def index
    @templates = Template.all
  end

  # Exibe um template especifico.
  #
  # @return [void]
  # @note Utiliza `@template`, definido pelo callback `set_template`.
  def show
  end

  # Prepara um novo template para cadastro.
  #
  # @return [void]
  # @note Instancia `@template` sem persistencia.
  def new
    @template = Template.new
  end

  # Carrega um template existente para edicao.
  #
  # @return [void]
  # @note Utiliza `@template`, definido pelo callback `set_template`.
  def edit
  end

  # Cria um novo template a partir dos parametros recebidos.
  #
  # @return [void]
  # @note Persiste o template quando valido e redireciona para sua pagina.
  def create
    @template = Template.new(template_params)

    if @template.save
      render_create_success(@template)
    else
      render_fail(:new, @template)
    end
  end

  # Atualiza um template existente.
  #
  # @return [void]
  # @note Persiste as alteracoes quando os dados sao validos.
  def update
    if @template.update(template_params)
      render_update_success(@template)
    else
      render_fail(:edit, @template)
    end
  end

  # Remove um template quando ele nao possui formularios vinculados.
  #
  # @return [void]
  # @note Pode impedir a exclusao e redirecionar com alerta.
  def destroy
    return render_destroy_restricted if @template.forms.any?

    @template.destroy!
    render_destroy_success
  end

  private

  # Busca o template referenciado pelo parametro `id`.
  #
  # @return [void]
  # @raise [ActiveRecord::RecordNotFound] quando o template nao existir.
  def set_template
    @template = Template.find(params.expect(:id))
  end

  # Filtra os parametros permitidos do template.
  #
  # @return [ActionController::Parameters] parametros seguros do template.
  # @note Aceita apenas `name` e `description`.
  def template_params
    params.expect(template: [ :name, :description ])
  end

  # Responde ao fluxo de sucesso da criacao de templates.
  #
  # @param template [Template] template recem-criado.
  # @return [void]
  # @note Redireciona em HTML e renderiza `show` em JSON.
  def render_create_success(template)
    respond_to do |format|
      format.html { redirect_to template, notice: "Template criado com sucesso" }
      format.json { render :show, status: :created, location: template }
    end
  end

  # Responde ao fluxo de sucesso da atualizacao de templates.
  #
  # @param template [Template] template atualizado.
  # @return [void]
  # @note Redireciona em HTML e renderiza `show` em JSON.
  def render_update_success(template)
    respond_to do |format|
      format.html { redirect_to template, notice: "Template atualizado com sucesso", status: :see_other }
      format.json { render :show, status: :ok, location: template }
    end
  end

  # Centraliza a resposta de falha em criacao ou atualizacao.
  #
  # @param action [Symbol] view a ser renderizada.
  # @param template [Template] template com erros de validacao.
  # @return [void]
  # @note Nao altera o banco; apenas renderiza a view ou retorna erros em JSON.
  def render_fail(action, template)
    respond_to do |format|
      format.html { render action, status: :unprocessable_content }
      format.json { render json: template.errors, status: :unprocessable_content }
    end
  end

  # Responde ao bloqueio da exclusao de um template vinculado a formularios.
  #
  # @return [void]
  # @note Redireciona para a listagem em HTML e retorna erro em JSON.
  def render_destroy_restricted
    respond_to do |format|
      format.html { redirect_to templates_path, alert: "Não é possível excluir um template que já possui formulários vinculados", status: :see_other }
      format.json { render json: { error: "Template has associated forms" }, status: :unprocessable_entity }
    end
  end

  # Responde ao fluxo de sucesso da exclusao de templates.
  #
  # @return [void]
  # @note Redireciona para a listagem em HTML e retorna `204 No Content` em JSON.
  def render_destroy_success
    respond_to do |format|
      format.html { redirect_to templates_path, notice: "Template excluído com sucesso", status: :see_other }
      format.json { head :no_content }
    end
  end
end
