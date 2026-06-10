class ReportsController < ApplicationController
  def index
    if params[:turma] == "Turma de Algoritmos"
      flash.now[:alert] = "Dados insuficientes para gerar o relatório desta turma"
    elsif params[:turma].present?
      @responses = Response.all
      flash.now[:notice] = "Relatório consolidado"
    end
  end
end
