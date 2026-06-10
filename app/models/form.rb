class Form < ApplicationRecord
  belongs_to :template, optional: true
  has_many :responses
  validates :template, presence: { message: "Você precisa selecionar um template para o formulário" }
end
