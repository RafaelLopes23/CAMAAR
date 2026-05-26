# Projeto CAMAAR - Sprint 1

**Grupo 3**

**Integrantes:**
- Rebeca de Souza Coutinho, 222001430
- Rafael Lopes Cordeiro, 202033688

**Escopo do Projeto:** 
O projeto CAMAAR é um sistema desenvolvido em Ruby on Rails para auxiliar no gerenciamento acadêmico, organizando informações de disciplinas, turmas, docentes e discentes de forma estruturada e integrada.

---

## Papéis do Grupo
- **Scrum Master:** Rafael Lopes Cordeiro
- **Product Owner:** Rebeca de Souza Coutinho

## Funcionalidades e Regras de Negócio
Durante esta sprint, nosso foco foi a issue **#100 - Cadastrar usuários do sistema**. O fluxo principal consiste em um Administrador importar os dados (alunos e professores) e o sistema gerenciar o cadastro. As funcionalidades extraídas para o grupo foram:

1. **Importação de Dados do SIGAA (Administrador)**
   - *Regra de Negócio:* O Administrador deve submeter um arquivo válido contendo a lista de participantes. O sistema valida se o usuário já existe e realiza um "pré-cadastro". Um email é gerado contendo o link para a definição de senha.

2. **Ativação e Definição de Senha (Participante)**
   - *Regra de Negócio:* O usuário importado só terá o acesso garantido e o cadastro efetivado no CAMAAR quando definir sua senha inicial, que deve possuir pelo menos 8 caracteres por motivos de segurança.

## Divisão de Responsabilidades
- **Rafael Lopes Cordeiro:** Responsável por elaborar e implementar o cenário de "Importação de Dados do SIGAA".
- **Rebeca de Souza Coutinho:** Responsável por elaborar e implementar o cenário de "Ativação e Definição de Senha".

## Política de Branching
A equipe adotou o **GitHub Flow** como estratégia de versionamento para o projeto.
- A branch `main` sempre contém o código em estado de produção/estável.
- Novas funcionalidades e testes são desenvolvidos em branches criadas a partir da `main` com nomes descritivos (ex: `sprint-1`, `feature-cadastro`).
- Uma vez que o trabalho na branch está concluído, é aberto um **Pull Request** para a branch principal (`main`).
- Após revisão e aprovação, a branch do Pull Request é integrada e feito o merge na `main`.
