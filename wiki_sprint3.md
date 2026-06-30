# Projeto CAMAAR - Sprint 3

**Grupo 3**

## Integrantes

* Rebeca de Souza Coutinho — 222001430
* Rafael Lopes Cordeiro — 202033688

## Escopo do Projeto

O projeto CAMAAR é um sistema desenvolvido em Ruby on Rails para auxiliar no gerenciamento acadêmico, organizando informações de disciplinas, turmas, docentes e discentes de forma estruturada e integrada.

---

## Papéis do Grupo

* **Scrum Master:** Rebeca de Souza Coutinho
* **Product Owner:** Rafael Lopes Cordeiro

---

## Objetivo da Sprint

O foco da Sprint 3 foi a melhoria da qualidade interna do sistema por meio de refatorações, redução da complexidade dos métodos, eliminação de duplicações de código, aumento da cobertura dos testes automatizados e documentação das alterações realizadas.

---

## Funcionalidades Implementadas

As funcionalidades desenvolvidas nas sprints anteriores permaneceram como escopo principal da aplicação:

* Gerenciamento de Templates (Criação, Edição, Exclusão e Visualização);
* Formulários de Avaliação (Criação, Visualização e Resposta);
* Relatórios Gerenciais;
* Importação de Participantes;
* Definição de Senha;
* Autenticação e Login.

---

## Divisão de Responsabilidades

### Rafael Lopes Cordeiro

*
*
* Documentação do código RDoc
* Documentação da Sprint 3

### Rebeca de Souza Coutinho

* Análise dos resultados gerados pelo RubyCritic e refatoração de métodos com alta complexidade;
* Implementação e correção dos testes automatizados;
* Análise da cobertura de testes utilizando SimpleCov;
* Documentação da Sprint 3.

---

## Funcionalidades BDD (Cucumber)

As funcionalidades foram descritas e implementadas utilizando a sintaxe Gherkin (Cucumber), contemplando cenários principais e alternativos:

* **Sistema de Login (`login.feature`)**: autenticação de usuários e tratamento de credenciais inválidas;
* **Criar Template (`criar_template.feature`)**: criação de templates e validação de campos obrigatórios;
* **Criar Formulário (`criar_formulario.feature`)**: disponibilização de formulários de avaliação;
* **Visualização de Templates (`visualizacao_templates.feature`)**: exibição dos templates cadastrados;
* **Edição e Exclusão de Templates (`edicao_delecao_templates.feature`)**: atualização e remoção de templates;
* **Visualização de Formulários (`visualizacao_formularios.feature`)**: listagem de avaliações disponíveis;
* **Responder Formulário (`responder_formulario.feature`)**: envio de respostas pelos participantes;
* **Gerar Relatório (`gerar_relatorio.feature`)**: consolidação e exibição dos resultados;
* **Importação de Dados**: validação da importação de arquivos CSV;
* **Definição de Senha**: validação do cadastro e ativação de usuários.

---

# Refatoração de Código e Cobertura de Testes

Nesta sprint foram utilizadas ferramentas de análise estática e qualidade de software para identificar necessiadade de refatoção e validar os resultados obtidos.

## Ferramentas Utilizadas

* 
* **RubyCritic:** identificação de code smells, duplicação de código e métricas de qualidade;
* **SimpleCov:** medição da cobertura dos testes automatizados.
*
* 



---

## Análise com RubyCritic

O RubyCritic foi utilizado para realizar uma análise estática do projeto, identificando problemas relacionados à complexidade, duplicação de código e manutenção.

### Melhorias Realizadas

Durante a sprint foram realizadas as seguintes refatorações:

* Extração de métodos para reduzir a complexidade dos controllers;
* Remoção de chamadas duplicadas identificadas pelo RubyCritic;
* Reorganização da lógica de autenticação e importação de participantes;
* Padronização dos métodos CRUD;
* Redução da duplicação de código entre controllers;
* Melhoria da legibilidade e manutenção do código.

---

## Comparação das Métricas

| Método                                | Score Antes | Score Depois |
| ------------------------------------- | ----------- | ------------ |
| ImportsController#create              | 24.5        | 8.2          |
| ImportsController#import_participants | 17.34       | 6.1          |
| FormsController#create                | 26.8        | 7.4          |
| FormsController#update                | 22.1        | 7.4          |
| FormsController#destroy               | 11.3        | 5.2          |
| ResponsesController#create            | 25.2        | 7.1          |
| ResponsesController#update            | 21.8        | 7.1          |

### Resultados Obtidos

Após as refatorações realizadas:

* Redução significativa da duplicação de código;
* Diminuição da complexidade dos métodos;
* Eliminação dos principais code smells identificados;
* Adequação dos métodos ao limite recomendado de ABC Score (< 20);
* Melhor organização das responsabilidades dos controllers.

---

## Cobertura de Testes com SimpleCov

A ferramenta SimpleCov foi utilizada para mensurar a cobertura dos testes automatizados. O objetivo da sprint era garantir cobertura superior a 90% para todos os controllers e models implementados pelo grupo.

### Comparação da Cobertura

| Controller          | Cobertura Inicial | Cobertura Final |
| ------------------- | ----------------- | --------------- |
| ReportsController   | 57.14%            | 100%            |
| TemplatesController | 82.61%            | 100%            |
| PasswordsController | 84.21%            | 100%            |
| FormsController     | 87.88%            | 100%            |
| ResponsesController | 80.00%            | 93.94%          |

### Ações Realizadas

* Criação de cenários adicionais de teste;
* Cobertura de fluxos alternativos e casos de erro;
* Testes para validação de regras de negócio;
* Simulação de autenticação para acesso às rotas protegidas;
* Correção de fixtures utilizadas nos testes.

Muitos testes inicialmente falhavam com o código HTTP **302 Found** devido ao redirecionamento automático para a tela de login. Para resolver esse problema, foi implementado um processo de autenticação durante a execução dos testes:

```ruby
setup do
  @user = users(:one)

  post sessions_url, params: {
    email: @user.email,
    password: "secret"
  }
end
```

Essa abordagem permitiu testar corretamente as funcionalidades protegidas por autenticação.

---

## Evidências

Foram gerados relatórios pelas ferramentas RubyCritic e SimpleCov para validar os resultados obtidos.


# Overview da ferramenta Rubycritic
<img width="1735" height="636" alt="Captura de tela 2026-06-30 174132" src="https://github.com/user-attachments/assets/137d7cad-a272-4924-8ca9-fbe279d30a2c" />

# Cobertura de código dos controllers e models
<img width="1796" height="656" alt="Captura de tela 2026-06-30 174229" src="https://github.com/user-attachments/assets/94cbe680-4ea0-41ca-9c20-62f9d5e139f2" />

<img width="1792" height="532" alt="Captura de tela 2026-06-30 174244" src="https://github.com/user-attachments/assets/4f8f7ab7-ce97-439b-a270-5a9cd52cd7a9" />


### RubyCritic

* Redução dos valores de complexidade dos métodos críticos;
* Eliminação de duplicações identificadas nos controllers;
* Melhoria da avaliação geral dos arquivos analisados.

### SimpleCov

* Cobertura superior a 90% nos controllers desenvolvidos pelo grupo;
* Cobertura de 100% em diversos controllers após a ampliação dos testes;
* Validação dos fluxos principais e alternativos da aplicação.

---

## Conclusão

A Sprint 3 teve como foco principal a melhoria da qualidade interna do sistema CAMAAR. Por meio da utilização das ferramentas  RubyCritic e SimpleCov, foi possível identificar pontos de melhoria e aplicar refatorações que reduziram a complexidade do código, eliminaram duplicações e aumentaram significativamente a cobertura dos testes automatizados.

Ao final da sprint, todos os controllers desenvolvidos pelo grupo atingiram cobertura superior a 90%, atendendo aos requisitos estabelecidos. Além disso, as refatorações tornaram o código mais organizado, legível e fácil de manter, contribuindo para a evolução sustentável do projeto.

Após a conclusão das atividades, as alterações foram submetidas por meio de Pull Requests, revisadas e integradas à branch principal do projeto.
