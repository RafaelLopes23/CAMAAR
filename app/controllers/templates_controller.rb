# Controller responsável por gerenciar o ciclo de vida de Templates.
# :reek:InstanceVariableAssumption
class TemplatesController < ApplicationController
  before_action :set_template, only: %i[ show edit update destroy ]

  # GET /templates
  def index
    @templates = Template.all
  end

  # GET /templates/1
  def show
  end

  # GET /templates/new
  def new
    @template = Template.new
  end

  # GET /templates/1/edit
  def edit
  end

  # POST /templates
  def create
    @template = Template.new(template_params)

    if @template.save
      render_create_success(@template)
    else
      render_fail(:new, @template)
    end
  end

  # PATCH/PUT /templates/1
  def update
    if @template.update(template_params)
      render_update_success(@template)
    else
      render_fail(:edit, @template)
    end
  end

  # DELETE /templates/1
  def destroy
    return render_destroy_restricted if @template.forms.any?

    @template.destroy!
    render_destroy_success
  end

  private

  def set_template
    @template = Template.find(params.expect(:id))
  end

  def template_params
    params.expect(template: [ :name, :description ])
  end

  # --- Métodos auxiliares otimizados ---

  def render_create_success(template)
    respond_to do |format|
      format.html { redirect_to template, notice: "Template criado com sucesso" }
      format.json { render :show, status: :created, location: template }
    end
  end

  def render_update_success(template)
    respond_to do |format|
      format.html { redirect_to template, notice: "Template atualizado com sucesso", status: :see_other }
      format.json { render :show, status: :ok, location: template }
    end
  end

  def render_fail(action, template)
    respond_to do |format|
      format.html { render action, status: :unprocessable_content }
      format.json { render json: template.errors, status: :unprocessable_content }
    end
  end

  def render_destroy_restricted
    respond_to do |format|
      format.html { redirect_to templates_path, alert: "Não é possível excluir um template que já possui formulários vinculados", status: :see_other }
      format.json { render json: { error: "Template has associated forms" }, status: :unprocessable_entity }
    end
  end

  def render_destroy_success
    respond_to do |format|
      format.html { redirect_to templates_path, notice: "Template excluído com sucesso", status: :see_other }
      format.json { head :no_content }
    end
  end
end