# Modelo que representa um template reutilizavel para formularios de avaliacao.
class Template < ApplicationRecord
  # O 'dependent: :destroy' garante que os forms associados
  # sejam apagados junto, permitindo a exclusão do template.
  has_many :forms, dependent: :destroy

  validates :name, presence: { message: "O nome do template é obrigatório" }
end
