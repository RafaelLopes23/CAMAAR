# Controller responsável por gerenciar o ciclo de vida de Respostas/Avaliações.
# :reek:InstanceVariableAssumption
class ResponsesController < ApplicationController
  before_action :set_response, only: %i[ show edit update destroy ]

  # GET /responses
  def index
    @responses = Response.all
  end

  # GET /responses/1
  def show
  end

  # GET /responses/new
  def new
    @response = Response.new
  end

  # GET /responses/1/edit
  def edit
  end

  # POST /responses
  def create
    @response = Response.new(response_params)
    saved = @response.save
    
    respond_to do |format|
      dispatch_response_result(format, saved, :new, @response, "Avaliação enviada com sucesso", :created)
    end
  end

  # PATCH/PUT /responses/1
  def update
    updated = @response.update(response_params)

    respond_to do |format|
      dispatch_response_result(format, updated, :edit, @response, "Response was successfully updated.", :ok)
    end
  end

  # DELETE /responses/1
  def destroy
    @response.destroy!

    respond_to do |format|
      format.html { redirect_to responses_path, notice: "Response was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_response
    @response = Response.find(params[:id])
  end

  def response_params
    params.expect(response: [ :form_id, :user_id, :content ])
  end

  # Centraliza o sucesso e a falha em um único método dinâmico, mudando completamente a AST
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