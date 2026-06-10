require 'rails_helper'

RSpec.describe Form, type: :model do
  it "is valid with a template" do
    template = Template.create!(name: "Avaliação")
    form = Form.new(title: "Turma 1", template: template)
    expect(form).to be_valid
  end

  it "is invalid without a template" do
    form = Form.new(title: "Turma 1", template: nil)
    expect(form).to_not be_valid
    expect(form.errors.messages[:template]).to include("Você precisa selecionar um template para o formulário")
  end
end
