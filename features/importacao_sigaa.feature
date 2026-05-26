# language: pt

Funcionalidade: Importar dados de usuários do SIGAA
  Como um Administrador
  Eu quero cadastrar participantes de turmas do SIGAA ao importar dados de usuários novos para o sistema
  A fim de pré-cadastrá-los para que eles acessem o sistema CAMAAR

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
