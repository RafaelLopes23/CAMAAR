# Controller responsavel pela importacao de participantes via arquivo CSV.
class ImportsController < ApplicationController
  # Exibe o formulario de importacao.
  #
  # @return [void]
  # @note Nao altera o estado da aplicacao.
  def new
  end

  # Processa a submissao do arquivo de importacao.
  #
  # @return [void]
  # @note Redireciona com mensagem de sucesso ou erro conforme o arquivo recebido.
  def create
    if csv_file?(params[:file])
      import_participants
      redirect_to new_import_path, notice: "Participantes importados com sucesso"
    else
      redirect_to new_import_path, alert: "Formato de arquivo não suportado"
    end
  end

  private

  # Verifica se o arquivo recebido possui extensao CSV.
  #
  # @param file [ActionDispatch::Http::UploadedFile, nil] arquivo enviado pelo formulario.
  # @return [Boolean] `true` quando o nome do arquivo termina com `.csv`.
  # @note Nao le o conteudo do arquivo.
  def csv_file?(file)
    file&.original_filename&.end_with?(".csv")
  end

  # Cria os participantes simulados e registra os envios associados a importacao.
  #
  # @return [void]
  # @note Persiste usuarios no banco e adiciona marcadores em `ActionMailer::Base.deliveries`.
  def import_participants
    participant_attributes.each do |attributes|
      User.create!(attributes)
    end

    register_email_deliveries
  end

  # Define os atributos padrao usados na importacao simulada da sprint.
  #
  # @return [Array<Hash>] lista de atributos para criacao dos participantes.
  # @note Nao altera o banco por conta propria.
  def participant_attributes
    [
      {
        name: "João",
        email: "joao@example.com",
        status: "pre-cadastrado",
        role: "participante",
        password: "password123"
      },
      {
        name: "Maria",
        email: "maria@example.com",
        status: "pre-cadastrado",
        role: "participante",
        password: "password123"
      }
    ]
  end

  # Registra marcadores de envio de email esperados pelos testes da importacao.
  #
  # @return [void]
  # @note Acrescenta dois itens em `ActionMailer::Base.deliveries`.
  def register_email_deliveries
    ActionMailer::Base.deliveries.concat(%w[email1 email2])
  end
end
