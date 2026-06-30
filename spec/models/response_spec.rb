require 'rails_helper'

RSpec.describe Response, type: :model do
  describe 'associations' do
    it 'belongs to a form' do
      response = build_response
      expect(response).to respond_to(:form)
    end

    it 'belongs to a user' do
      response = build_response
      expect(response).to respond_to(:user)
    end
  end

  describe 'validations' do
    context 'when content is present' do
      it 'is valid' do
        response = build_response(content: "Minha resposta")
        expect(response).to be_valid
      end
    end

    context 'when content is missing' do
      it 'is invalid' do
        response = build_response(content: nil)
        expect(response).to_not be_valid
      end

      it 'has appropriate error message' do
        response = build_response(content: nil)
        response.valid?
        expect(response.errors[:content]).to be_present
      end
    end
  end

  private

  def build_response(content: "Resposta", form: nil, user: nil)
    Response.new(
      form: form || build_form,
      user: user || build_user,
      content:
    )
  end

  def build_template
    Template.create!(name: "Avaliação")
  end

  def build_form
    Form.create!(title: "Turma", template: build_template)
  end

  def build_user
    User.create!(
      name: "Aluno",
      email: "aluno#{rand(1000)}@example.com",
      password: "Senha123",
      password_confirmation: "Senha123"
    )
  end
end
