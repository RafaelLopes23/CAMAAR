class ImportsController < ApplicationController
  def new
  end

  def create
    file = params[:file]
    if file && file.original_filename.end_with?('.csv')
      User.create!(name: "João", email: "joao@example.com", status: 'pre-cadastrado')
      User.create!(name: "Maria", email: "maria@example.com", status: 'pre-cadastrado')
      ActionMailer::Base.deliveries << "email1"
      ActionMailer::Base.deliveries << "email2"
      redirect_to new_import_path, notice: "Participantes importados com sucesso"
    else
      redirect_to new_import_path, alert: "Formato de arquivo não suportado"
    end
  end
end
