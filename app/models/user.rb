class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || password.present? }

  enum :role, { administrador: "Administrador", participante: "Participante" }
  enum :status, { ativo: "ativo", "pre-cadastrado": "pre-cadastrado", inativo: "inativo" }

  def self.authenticate(email, password)
    user = find_by(email: email)
    user&.authenticate(password)
  end
end
