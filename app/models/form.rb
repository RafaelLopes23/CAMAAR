# Modelo que representa um formulario de avaliacao baseado em um template.
class Form < ApplicationRecord
  belongs_to :template, optional: true

  # Adicionado o dependent: :destroy para apagar as respostas vinculadas
  # quando o formulário for excluído em cascata.
  has_many :responses, dependent: :destroy

  validates :template, presence: { message: "Você precisa selecionar um template para o formulário" }
  validates :title, presence: true
end
