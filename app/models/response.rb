class Response < ApplicationRecord
  belongs_to :form
  belongs_to :user
  validates :content, presence: { message: "Por favor, preencha todos os campos obrigatórios" }
end
