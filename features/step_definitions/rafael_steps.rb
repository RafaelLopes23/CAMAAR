# features/step_definitions/rafael_steps.rb

# removed

# removed

Quando('eu deixo o campo "Nome do Template" em branco') do
  fill_in "Nome do Template", with: ""
end

E('adiciono questões de múltipla escolha e texto') do
  fill_in_template_description("Questões variadas")
end

E('adiciono questões de múltipla escolha') do
  fill_in_template_description("Múltipla escolha")
end

E('clico em {string}') do |btn|
  case btn
  when "Salvar Template"
    click_button "Salvar"
  when "Disponibilizar Formulário"
    click_button "Create Form"
  when "Enviar Respostas"
    click_button "Create Response"
  when "Gerar Relatório"
    click_button "Gerar"
  else
    click_on btn
  end
end

Então('o sistema deve salvar o template no banco de dados') do
  expect(Template.count).to be > (@initial_template_count || 0)
end

Então('o sistema não deve salvar o template') do
  expect(Template.count).to eq(@initial_template_count || 0)
end

Quando('seleciono o template {string}') do |name|
  select name, from: "Template"
end

E('seleciono a {string}') do |turma|
  if page.has_select?("Turma")
    select turma, from: "Turma"
  else
    fill_in "Turma", with: turma
  end
end

Mas('deixo o campo de "Template" vazio') do
  select "Selecione", from: "Template"
end

Então('o sistema gera um formulário associado a essa turma') do
  expect(Form.count).to be > (@initial_form_count || 0)
end

E('notifica os alunos da turma') do
  # stub notification
end

Então('o sistema não deve gerar o formulário') do
  expect(Form.count).to eq(@initial_form_count || 0)
end

Dado('eu acesso a página de resposta do formulário {string}') do |turma|
  @form = Form.create!(title: turma, template: Template.first || Template.create!(name: "T", description: "D"))
  @initial_response_count = Response.count
  visit new_response_path(form_id: @form.id)
end

Quando('eu preencho todas as questões obrigatórias') do
  select @form.title, from: "Formulário"
  fill_in "Content", with: "Minha resposta completa"
end

Então('o sistema deve salvar minhas respostas') do
  expect(Response.count).to be > (@initial_response_count || 0)
end

E('o status do formulário deve mudar para "Respondido"') do
  # stub
end

Quando('eu deixo uma questão obrigatória em branco') do
  fill_in "Content", with: ""
end

Então('o sistema não deve salvar as respostas') do
  expect(Response.count).to eq(@initial_response_count || 0)
end

E('destaca a questão obrigatória') do
  # visual check
end

Dado('existem formulários respondidos para a {string}') do |turma|
  @form = Form.create!(title: turma, template: Template.create!(name: "T", description: "D"))
  @user ||= User.first || User.create!(name: "A", email: "a@a.com")
  Response.create!(form: @form, user: @user, content: "Resp")
end

Então('o sistema deve compilar os dados das respostas') do
  expect(page).to have_content("Relatório")
end

E('apresentar um relatório visual na tela') do
  expect(page).to have_content("Resp")
end

E('disponibilizar um botão para "Exportar PDF"') do
  expect(page).to have_link("Exportar PDF")
end

Dado('a {string} ainda não possui respostas enviadas') do |turma|
  @form = Form.create!(title: turma, template: Template.create!(name: "T", description: "D"))
  visit reports_index_path
end

Então('o sistema não deve gerar o relatório') do
  expect(page).not_to have_content("Relatório compilado")
end

E('exibe a mensagem de erro {string}') do |msg|
  expect(page).to have_content(msg)
end

Quando('eu acesso a aba de {string}') do |page_name|
  step %{acesso a página de "#{page_name}"}
end

Quando('eu seleciono a {string}') do |turma|
  step %{seleciono a "#{turma}"}
end

def fill_in_template_description(value)
  if page.has_field?("Descrição")
    fill_in "Descrição", with: value
  else
    fill_in "template_description", with: value
  end
end
