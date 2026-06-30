# Represents a user's response to a form
class Response < ApplicationRecord
  belongs_to :form
  belongs_to :user
  validates :content, presence: { message: "Por favor, preencha todos os campos obrigatórios" }
end
