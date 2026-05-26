# language: pt

Funcionalidade: Definição de senha de usuários pré-cadastrados
  Como um Participante (Aluno/Professor)
  Eu quero definir minha senha de acesso
  A fim de efetivar meu cadastro para acessar o sistema CAMAAR

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
