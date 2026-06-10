require 'rails_helper'

RSpec.describe Response, type: :model do
  let(:template) { Template.create!(name: "Avaliação") }
  let(:form) { Form.create!(title: "Turma", template: template) }
  let(:user) { User.create!(name: "Aluno", email: "aluno@example.com") }

  it "is valid with content" do
    response = Response.new(form: form, user: user, content: "Minha resposta")
    expect(response).to be_valid
  end

  it "is invalid without content" do
    response = Response.new(form: form, user: user, content: nil)
    expect(response).to_not be_valid
    expect(response.errors.messages[:content]).to include("Por favor, preencha todos os campos obrigatórios")
  end
end
