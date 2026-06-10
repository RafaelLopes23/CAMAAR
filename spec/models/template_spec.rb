require 'rails_helper'

RSpec.describe Template, type: :model do
  it "is valid with a name" do
    template = Template.new(name: "Avaliação")
    expect(template).to be_valid
  end

  it "is invalid without a name" do
    template = Template.new(name: nil)
    expect(template).to_not be_valid
    expect(template.errors.messages[:name]).to include("O nome do template é obrigatório")
  end
end
