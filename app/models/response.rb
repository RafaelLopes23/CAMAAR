# Modelo que representa a resposta enviada por um usuario para um formulario.
class Response < ApplicationRecord
  belongs_to :form
  belongs_to :user
  validates :content, presence: { message: "Por favor, preencha todos os campos obrigatórios" }
end
