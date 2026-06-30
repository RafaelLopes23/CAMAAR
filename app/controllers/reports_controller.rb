# Controller responsavel pela exibicao de relatorios consolidados.
class ReportsController < ApplicationController
  # Exibe o relatorio conforme a turma solicitada.
  #
  # @return [void]
  # @note Pode carregar respostas em `@responses` e definir mensagens em `flash.now`.
  def index
    if params[:turma] == "Turma de Algoritmos"
      flash.now[:alert] = "Dados insuficientes para gerar o relatório desta turma"
    elsif params[:turma].present?
      @responses = Response.all
      flash.now[:notice] = "Relatório consolidado"
    end
  end
end
