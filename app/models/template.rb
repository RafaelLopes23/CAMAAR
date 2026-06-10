class Template < ApplicationRecord
  has_many :forms
  validates :name, presence: { message: "O nome do template é obrigatório" }
end
