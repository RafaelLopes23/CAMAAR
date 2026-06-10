Dado('que eu estou logado como {string}') do |role|
  @user = User.create!(name: "Admin", email: "admin@example.com", role: role, password_digest: "password")
  visit new_session_path
  fill_in "Email", with: "admin@example.com"
  fill_in "Senha", with: "password"
  click_button "Entrar"
end

E(/^(?:eu )?acesso a página de "([^"]*)"$/) do |page_name|
  case page_name
  when "Importação de Participantes"
    visit new_import_path
  when "Novo Template"
    visit new_template_path
  when "Criar Avaliação"
    visit new_form_path
  when "Relatórios"
    visit reports_index_path
  end
end

Quando('eu envio um arquivo válido com os dados dos novos usuários') do
  require 'csv'
  File.write("tmp/usuarios_validos.csv", "name,email\nJoão,joao@example.com\nMaria,maria@example.com")
  attach_file "Arquivo", "tmp/usuarios_validos.csv"
  click_button "Importar"
end

Então('o sistema deve criar um pré-cadastro para os usuários') do
  expect(User.where(status: 'pre-cadastrado').count).to eq(2)
end

E('deve enviar um email com um link de definição de senha para os novos usuários cadastrados') do
  expect(ActionMailer::Base.deliveries.count).to be >= 2
end

E('o sistema exibe a mensagem {string}') do |msg|
  expect(page).to have_content(msg)
end

Quando('eu envio um arquivo em formato não suportado \(ex: .png)') do
  File.write("tmp/arquivo.png", "dummy png content")
  attach_file "Arquivo", "tmp/arquivo.png"
  click_button "Importar"
end

Então('o sistema não deve importar nenhum dado') do
  # Only the Admin should exist
  expect(User.count).to eq(1)
end

E('o sistema exibe a mensagem de erro {string}') do |msg|
  expect(page).to have_content(msg)
end

Dado('que eu sou um usuário pré-cadastrado via importação') do
  @user = User.create!(name: "João", email: "joao@example.com", role: "Participante", status: "pre-cadastrado")
end

E('eu acesso o link recebido por email para {string}') do |link_name|
  visit edit_password_path(user_id: @user.id)
end

Quando('eu preencho o campo {string} com {string}') do |field, value|
  fill_in field, with: value
end

E('clico no botão {string}') do |btn|
  mapped_btn = case btn
               when "Enviar Respostas" then "Create Response"
               else btn
               end
  click_button mapped_btn
end

Então('o meu cadastro de usuário é ativado no sistema CAMAAR') do
  @user.reload
  expect(@user.status).to eq("ativo")
end

E('eu sou redirecionado para a tela de Login') do
  expect(current_path).to eq(new_session_path)
end

Então('o meu cadastro de usuário não é ativado') do
  @user.reload
  expect(@user.status).to eq("pre-cadastrado")
end
