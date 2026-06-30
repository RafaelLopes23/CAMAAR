# Projeto CAMAAR - Sprint 3

**Grupo 3**

## Integrantes

- Rebeca de Souza Coutinho - 222001430
- Rafael Lopes Cordeiro - 202033688

## Escopo do Projeto

O projeto CAMAAR e um sistema desenvolvido em Ruby on Rails para apoiar a avaliacao de atividades academicas, organizando templates, formularios, respostas, autenticacao, importacao e relatorios em uma unica aplicacao.

---

## Papeis do Grupo

- **Scrum Master:** Rebeca de Souza Coutinho
- **Product Owner:** Rafael Lopes Cordeiro

---

## Objetivo da Sprint

O foco da Sprint 3 foi melhorar a qualidade interna do sistema por meio de refatoracao, analise de metricas, ampliacao da cobertura dos testes e documentacao do codigo, seguindo os topicos exigidos na entrega.

---

## Divisao de Responsabilidades

### Rafael Lopes Cordeiro

- Refatoracao dos metodos com maior ramificacao;
- Ajustes de Happy Path e Sad Path em testes automatizados;
- Documentacao RDoc nos controllers e models;
- Consolidacao final da `wiki_sprint3.md` e execucao das validacoes finais.

### Rebeca de Souza Coutinho

- Analise de qualidade com RubyCritic;
- Analise de cobertura com SimpleCov;
- Ajustes e ampliacao de testes automatizados;
- Apoio na documentacao da sprint.

---

## Funcionalidades Mantidas

As funcionalidades implementadas nas sprints anteriores permaneceram funcionando apos as refatoracoes:

- Gerenciamento de Templates;
- Criacao e visualizacao de Formularios;
- Resposta de Formularios;
- Relatorios Gerenciais;
- Importacao de Participantes;
- Definicao de Senha;
- Login e autenticacao.

---

## Ferramentas Utilizadas

- **Saikuro:** adicionada ao projeto para analise de complexidade ciclomática;
- **RubyCritic:** analise de ABC Score, code smells e qualidade geral;
- **SimpleCov:** medicao da cobertura de testes;
- **RDoc:** documentacao do codigo;
- **RuboCop (`Metrics/CyclomaticComplexity` e `Metrics/AbcSize`):** validacao objetiva dos limites exigidos na branch.

---

## Topico 1 - Complexidade Ciclomatica < 10 por Metodo

### Trabalho realizado

Este topico ficou concentrado principalmente nas refatoracoes feitas por Rafael para reduzir ramificacao e duplicacao nos controllers.

### Refatoracoes aplicadas

| Arquivo / Metodo | Ajuste realizado | Objetivo |
| ---------------- | ---------------- | -------- |
| `FormsController#create` | Extracao da resposta para `respond_with_form_result` | Reduzir logica condicional dentro da action |
| `FormsController#update` | Reuso da mesma rotina auxiliar de resposta | Evitar duplicacao de fluxo de sucesso/erro |
| `ImportsController#create` | Separacao em `csv_file?`, `import_participants`, `participant_attributes` e `register_email_deliveries` | Diminuir acoplamento e simplificar leitura |
| `PasswordsController#update` | Separacao em `password_valid?`, `activate_user_and_redirect` e `handle_invalid_password` | Reduzir complexidade da action principal |

### Validacao executada

Comando utilizado:

```bash
bundle exec rubocop --only Metrics/CyclomaticComplexity app/controllers app/models
```

Resultado obtido:

- `13 files inspected, no offenses detected`
- Nenhum metodo analisado ultrapassou o limite configurado para complexidade ciclomática.

### Observacao sobre o Saikuro

A gem `saikuro` foi adicionada ao projeto, conforme solicitado no enunciado. No ambiente atual desta branch, usando Ruby 3.4, a ferramenta apresenta incompatibilidades com APIs antigas do Ruby/RDoc e nao conclui a analise. Para garantir a validacao pratica da branch, o limite foi confirmado com `RuboCop`, que passou sem offenses.

---

## Topico 2 - ABC Score < 20 por Metodo

### Trabalho realizado

Este topico corresponde ao trabalho da Rebeca com a analise de qualidade via RubyCritic e revisao das areas mais sensiveis do projeto.

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

### Validacoes executadas

Comandos utilizados:

```bash
bundle exec rubycritic app/controllers app/models --no-browser
bundle exec rubocop --only Metrics/AbcSize app/controllers app/models
```

Resultados obtidos:

- **RubyCritic:** relatorio gerado em `tmp/rubycritic/overview.html`
- **Score geral do RubyCritic:** `91.46`
- **RuboCop / ABC Size:** `13 files inspected, no offenses detected`

### Interpretacao

- O relatorio do RubyCritic foi gerado com sucesso para controllers e models;
- A checagem objetiva de `ABC Size` tambem passou sem offenses;
- Dessa forma, a branch ficou dentro do requisito de manter os metodos abaixo do limite exigido.



---

## Topico 3 - Cobertura de Testes > 90%

### Trabalho realizado

Este topico ficou ligado ao trabalho da Rebeca com `SimpleCov`, ampliacao de testes e verificacao da cobertura dos arquivos implementados pelo grupo.

### Validacoes executadas

Comandos utilizados:

```bash
bundle exec rails test
bundle exec rspec
```

Resultados gerais:

- **Rails test:** `42 runs, 92 assertions, 0 failures, 0 errors`
- **RSpec:** `17 examples, 0 failures`
- **Line Coverage total:** `96.8% (212 / 219)`

### Cobertura por controller/model no relatorio consolidado

Dados extraidos de `tmp/rubycritic/simple_cov_index.html`:

| Arquivo| Cobertura Inicial | Cobertura Final |
| ------- | --------- |
| `ApplicationController`|83.41% | 91.67% |
| `FormsController` | 87.88% | 100.00% |
| `ImportsController`|91.00% | 100.00% |
| `PasswordsController`|84.21% | 100.00% |
| `ReportsController` | 57.14% |100.00% |
| `ResponsesController`| 80.00% | 100.00% |
| `SessionsController` | 60.12% |100.00% |
| `TemplatesController` | 82.61% | 100.00% |
| `Form` | 100.00%|100.00% |
| `Response`|100.00% | 100.00% |
| `Template` | 100.00%| 100.00% |
| `User` |100.00% |100.00% |

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

### Conclusao do topico

Todos os controllers e models relevantes da aplicacao ficaram com cobertura acima de 90%, atendendo ao requisito da sprint.

---

## Topico 4 - Happy Path e Sad Path nas Features do Cucumber/RSpec

### Trabalho realizado

Este topico foi fechado com ajustes conjuntos nos testes, com foco maior do Rafael na parte que ainda faltava na branch.

### Ajustes aplicados

- Inclusao de Sad Path em `ResponsesControllerTest`;
- Inclusao de Sad Path em `ImportsControllerTest`;
- Correcao dos steps do Cucumber para trabalhar com contagens relativas, evitando falso negativo por fixtures;
- Ajuste do `DatabaseCleaner` para `:truncation` no Cucumber com SQLite;
- Correcao dos steps de criacao de template para refletir os labels e botoes reais da interface.

### Validacoes executadas

Comandos utilizados:

```bash
bundle exec cucumber
bundle exec rspec
bundle exec rails test
```

Resultados obtidos:

- **Cucumber:** `16 scenarios, 105 steps, 0 failures`
- **RSpec:** `17 examples, 0 failures`
- **Rails test:** `42 runs, 0 failures, 0 errors`

### Conclusao do topico

Os fluxos principais e alternativos das funcionalidades existentes ficaram validados na branch, sem alterar os textos das features definidos anteriormente.

---

## Topico 5 - Documentacao do Codigo com RDoc

### Trabalho realizado

Este topico foi implementado por Rafael com documentacao nos controllers e models principais, incluindo:

- descricao breve do metodo;
- parametros aceitos;
- retorno esperado;
- efeitos colaterais, como persistencia, renderizacao e redirecionamento.

### Validacao executada

Comando utilizado:

```bash
bundle exec rdoc -C --dry-run app/controllers app/models
```

Resultado obtido:

- `100% documentation!`
- `13 classes` documentadas;
- `30 methods` documentados;
- `0 undocumented items`.

---

## Evidencias Consolidadas

Resumo final das verificacoes executadas na branch `release/sprint-3`:

- `bundle exec rails test` passou;
- `bundle exec rspec` passou;
- `bundle exec cucumber` passou;
- `bundle exec rubycritic app/controllers app/models --no-browser` gerou relatorio com score `91.46`;
- `bundle exec rubocop --only Metrics/CyclomaticComplexity app/controllers app/models` passou sem offenses;
- `bundle exec rubocop --only Metrics/AbcSize app/controllers app/models` passou sem offenses;
- `bundle exec rdoc -C --dry-run app/controllers app/models` retornou `100% documentation`.

---

## Conclusao

A Sprint 3 foi concluida com participacao dos dois integrantes nos pontos pedidos. Rafael concentrou o fechamento dos topicos 4 e 5, enquanto Rebeca ficou com a analise e consolidacao dos topicos 1, 2 e 3. Ao final da branch, os testes automatizados estao passando, a cobertura ficou acima de 90%, a documentacao RDoc ficou completa e as metricas objetivas de complexidade e ABC Size passaram nas verificacoes executadas no ambiente atual.

---

## Como Rodar o Projeto

No diretorio `CAMAAR`, executar:

```bash
bundle install
bin/rails db:prepare
bin/rails server
```

Depois disso, acessar no navegador:

- `http://localhost:3000`

Para rodar os testes e as validacoes principais:

```bash
bundle exec rails test
bundle exec rspec
bundle exec cucumber
bundle exec rubycritic app/controllers app/models --no-browser
bundle exec rubocop --only Metrics/CyclomaticComplexity app/controllers app/models
bundle exec rubocop --only Metrics/AbcSize app/controllers app/models
bundle exec rdoc -C --dry-run app/controllers app/models
```

## Caminhos Principais da Aplicacao

- `GET /sessions/new` : tela de login
- `GET /imports/new` : importacao de participantes
- `GET /templates` : listagem de templates
- `GET /templates/new` : criacao de template
- `GET /forms` : listagem de formularios
- `GET /forms/new` : criacao de formulario
- `GET /responses` : listagem de respostas
- `GET /responses/new` : envio de resposta
- `GET /reports/index` : relatorios
- `GET /password/edit?user_id=ID` : definicao/edicao de senha de usuario
