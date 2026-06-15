Dado('que eu estou logado como {string}') do |role|
  @user = User.create!(name: "Admin", email: "admin@example.com", role: role, password: "password", password_confirmation: "password")
  visit new_session_path
  fill_in "Email", with: "admin@example.com"
  fill_in "Senha", with: "password"
  click_button "Entrar"
end

Dado('que eu tenho um cadastro ativo no sistema') do
  @user = User.create!(
    name: "Test User",
    email: "usuario@example.com",
    role: "Participante",
    status: "ativo",
    password: "SenhaSegura123",
    password_confirmation: "SenhaSegura123"
  )
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
  when "Login"
    visit new_session_path
  when "Meus Templates"
    visit templates_path
  when "Meus Formulários"
    visit forms_path
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

Então('exibe a mensagem {string}') do |msg|
  expect(page).to have_content(msg)
end

Então('o sistema deve atualizar o template') do
  expect(page).to have_content("Template atualizado com sucesso")
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

# step `clico no botão {string}` removido para evitar ambiguidade com outro step similar

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

Então('eu devo ser redirecionado para a página inicial do meu perfil') do
  expect(current_path).to eq(new_import_path)
end

Então('eu não devo ser autenticado') do
  expect(page).to have_current_path(sessions_path)
  expect(page).to have_content("Email ou senha inválidos")
end

# Steps para visualização de templates
Dado('existem templates previamente criados no sistema') do
  @templates = [
    Template.create!(name: "Template Pesquisa", description: "Template para pesquisas de satisfação"),
    Template.create!(name: "Template Avaliação", description: "Template para avaliação de desempenho"),
    Template.create!(name: "Template Feedback", description: "Template para coleta de feedback")
  ]
end

Dado('não existem templates no sistema') do
  Template.destroy_all
end

Então('eu devo ver uma tabela com os templates existentes') do
  expect(page).to have_css('table')
end

Então('devo ver as opções de visualizar, editar e excluir para cada template') do
  @templates.each do |template|
    expect(page).to have_link("Visualizar", href: template_path(template))
    expect(page).to have_link("Editar", href: edit_template_path(template))
    expect(page).to have_link("Excluir", href: template_path(template))
  end
end

Então('a tabela de templates deve estar vazia') do
  # Verifica se não há nenhuma linha de dados (só há a mensagem de "vazio")
  expect(page).to have_css('table tbody tr td', text: 'Nenhum template encontrado')
end

# Steps para edição e deleção de templates
Dado('existe um template chamado {string}') do |name|
  @template = Template.create!(name: name, description: "Template de teste")
end

# Steps para visualização de formulários (participante)
Dado('existem formulários pendentes atribuídos a mim') do
  t1 = Template.create!(name: "T01", description: "D")
  t2 = Template.create!(name: "T02", description: "D")
  @forms = [
    Form.create!(title: "Form A", template: t1),
    Form.create!(title: "Form B", template: t2)
  ]
end

Dado('não existem formulários pendentes para mim') do
  # Criar um formulário e marcar como respondido pelo usuário atual
  tpl = Template.create!(name: "T-Respondido", description: "D")
  form = Form.create!(title: "Form Respondido", template: tpl)
  user = @user || User.first || User.create!(name: "U", email: "u@example.com", role: "Participante", password: "password", password_confirmation: "password")
  Response.create!(form: form, user: user, content: "Resposta")
end

Então('eu devo ver uma lista com os formulários não respondidos') do
  expect(page).to have_css('table')
  expect(page).to have_content('Responder')
end

Então('cada item da lista deve ter um botão "Responder"') do
  @forms.each do |f|
    expect(page).to have_link('Responder', href: new_response_path(form_id: f.id))
  end
end

Então('a lista de formulários deve estar vazia') do
  expect(page).to have_content('Você não possui formulários pendentes')
end

Dado('existe um template chamado {string} que já foi usado em formulários') do |name|
  @template = Template.create!(name: name, description: "Template em uso")
  Form.create!(title: "Formulário de teste", template: @template)
end

Quando('eu clico em {string} no template {string}') do |action, template_name|
  visit templates_path unless current_path == templates_path
  @last_template = Template.find_by(name: template_name)
  within(:xpath, "//tr[td[contains(normalize-space(.), '#{template_name}')]]") do
    case action
    when "Editar"
      click_link "Editar"
    when "Deletar", "Excluir"
      if has_link?("Excluir")
        click_link "Excluir"
      elsif has_button?("Excluir")
        click_button "Excluir"
      else
        raise "Link ou botão 'Excluir' não encontrado para template #{template_name}"
      end
    when "Visualizar"
      click_link "Visualizar"
    else
      raise "Ação desconhecida: #{action}"
    end
  end
end

E('modifico o campo {string} para {string}') do |field, value|
  case field
  when "Nome do Template"
    fill_in "Nome do Template", with: value
  when "Descrição"
    fill_in "Descrição", with: value
  end
end

Quando('clico no botão {string}') do |btn|
  mapped_btn = case btn
               when "Salvar" then "Salvar"
               when "Enviar Respostas" then "Create Response"
               else btn
               end
  click_button mapped_btn
end

E('confirmo a exclusão') do
  # Tenta aceitar modal de confirmação; se driver não suportar, envia DELETE diretamente
  begin
    page.accept_confirm do
      # nothing: we already clicked the link
    end
  rescue Capybara::NotSupportedByDriverError
    if @last_template
      page.driver.submit :delete, template_path(@last_template), {}
    else
      raise "Nenhum template salvo para exclusão; não foi possível confirmar com driver não-JS"
    end
  end
end



Então('o sistema não deve excluir o template') do
  expect(page).to have_content("Não é possível excluir um template que já possui formulários vinculados")
end
