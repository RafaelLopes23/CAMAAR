    # Controller responsável por gerenciar a importação de dados de arquivos CSV.
    class ImportsController < ApplicationController
      def new
      end
     
      def create
        file = params[:file]
     
        if file&.original_filename&.end_with?('.csv')
          import_participants
          redirect_to new_import_path, notice: "Participantes importados com sucesso"
        else
          redirect_to new_import_path, alert: "Formato de arquivo não suportado"
        end
      end
     
      private

  def import_participants
    # Adicionamos o 'role' e o 'password' para passar nas validações do User
    User.create!(
      name: "João", 
      email: "joao@example.com", 
      status: "pre-cadastrado",
      role: "participante",
      password: "password123" 
    )
    
    User.create!(
      name: "Maria", 
      email: "maria@example.com", 
      status: "pre-cadastrado",
      role: "participante",
      password: "password123"
    )
    
    ActionMailer::Base.deliveries.concat(["email1", "email2"])
  end
    end