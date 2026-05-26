# language: pt

Funcionalidade: Cadastrar usuários do sistema a partir de importação do SIGAA
  Como um Administrador
  Eu quero cadastrar participantes de turmas do SIGAA ao importar dados de usuários novos para o sistema
  A fim de que eles acessem o sistema CAMAAR e o cadastro seja efetivado após a definição de senha

  Cenário: Importação de dados com sucesso (Caminho Feliz)
    Dado que eu estou logado como "Administrador"
    E eu acesso a página de "Importação de Participantes"
    Quando eu envio um arquivo válido com os dados dos novos usuários
    Então o sistema deve criar um pré-cadastro para os usuários
    E deve enviar um email com um link de definição de senha para os novos usuários cadastrados
    E o sistema exibe a mensagem "Participantes importados com sucesso"

  Cenário: Importação de arquivo com formato inválido (Caminho Triste)
    Dado que eu estou logado como "Administrador"
    E eu acesso a página de "Importação de Participantes"
    Quando eu envio um arquivo em formato não suportado (ex: .png)
    Então o sistema não deve importar nenhum dado
    E o sistema exibe a mensagem de erro "Formato de arquivo não suportado"

  Cenário: Definição de senha com sucesso (Caminho Feliz)
    Dado que eu sou um usuário pré-cadastrado via importação
    E eu acesso o link recebido por email para "Definição de Senha"
    Quando eu preencho o campo "Nova Senha" com "SenhaSegura123"
    E eu preencho o campo "Confirmar Senha" com "SenhaSegura123"
    E clico no botão "Salvar e Efetivar Cadastro"
    Então o meu cadastro de usuário é ativado no sistema CAMAAR
    E eu sou redirecionado para a tela de Login
    E o sistema exibe a mensagem "Cadastro ativado com sucesso"

  Cenário: Definição de senha com tamanho insuficiente (Caminho Triste)
    Dado que eu sou um usuário pré-cadastrado via importação
    E eu acesso o link recebido por email para "Definição de Senha"
    Quando eu preencho o campo "Nova Senha" com "12345"
    E eu preencho o campo "Confirmar Senha" com "12345"
    E clico no botão "Salvar e Efetivar Cadastro"
    Então o meu cadastro de usuário não é ativado
    E o sistema exibe a mensagem de erro "A senha deve conter no mínimo 8 caracteres"
