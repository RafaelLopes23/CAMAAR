# Modelo que representa os usuarios autenticaveis do sistema.
class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || password.present? }

  enum :role, { administrador: "Administrador", participante: "Participante" }
  enum :status, { ativo: "ativo", "pre-cadastrado": "pre-cadastrado", inativo: "inativo" }

  # Autentica um usuario com base no email e na senha informados.
  #
  # @param email [String] email utilizado na tentativa de login.
  # @param password [String] senha em texto puro enviada pelo formulario.
  # @return [User, false, nil] usuario autenticado, `false` para senha incorreta
  #   ou `nil` quando o email nao existir.
  # @note Nao altera o banco de dados.
  def self.authenticate(email, password)
    user = find_by(email: email)
    user&.authenticate(password)
  end
end
