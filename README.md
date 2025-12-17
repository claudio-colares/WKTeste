## 🧱 Arquitetura Utilizada

O projeto segue uma separação clara de responsabilidades:

* **Model**

  * Representa as entidades de domínio (`PedidoVenda`, `PedidoVendaItem`, etc.)
  * Contém apenas dados e comportamentos básicos
* **DAO (Data Access Object)**

  * Responsável exclusivamente pelo acesso ao banco de dados
  * Centraliza SQL, persistência e leitura
* **Controller**

  * Orquestra as operações
  * Aplica regras de negócio
  * Gerencia transações
* **View (Forms)**

  * Atua como *Passive View*
  * Não contém SQL
  * Não conhece regras de negócio
  * Apenas exibe dados e dispara ações

Essa abordagem reduz acoplamento e facilita testes, manutenção e futuras alterações.

---

## 🗄️ Acesso a Dados e DBGrid

Os componentes visuais (`DBGrid`, `TFDQuery`) **não acessam diretamente o banco de dados**.

* O `TFDQuery` é utilizado **apenas como dataset em memória**
* O SQL e a conexão com o banco ficam **exclusivamente no DAO**
* O Controller decide **quando e como** os dados são carregados

Essa decisão evita SQL na View e mantém o formulário completamente desacoplado da camada de persistência.

---

## 🔄 Controle de Transações

O controle de transações foi centralizado no **Controller**, garantindo consistência entre operações relacionadas.

* `AutoCommit` desativado
* Transações explícitas (`StartTransaction`, `Commit`, `Rollback`)
* Cada operação crítica (inclusão, alteração e exclusão) é executada dentro de um bloco transacional

Exemplo conceitual:

* Início da transação no Controller
* Execução da operação no DAO
* Commit em caso de sucesso
* Rollback em caso de erro

Isso garante integridade dos dados e segue boas práticas para sistemas corporativos.

---

## 🛠️ Considerações de Implementação

A estratégia adotada foi priorizar a entrega de uma aplicação funcional, com a tela operante desde o início, para então refatorar e adequar a arquitetura às exigências do teste.

Por conta do tempo disponível, não foi utilizada uma TList para gerenciar os itens do pedido no Model, mantendo o controle diretamente via dataset.
Essa refatoração é viável e relativamente simples, mas foi postergada para não comprometer o prazo de entrega.

---

## 🎯 Considerações Finais

As decisões tomadas priorizaram:

* Código limpo e organizado
* Baixo acoplamento
* Clareza de responsabilidades
* Facilidade de manutenção e evolução

O projeto foi estruturado pensando em um **cenário real de sistemas Delphi corporativos**, onde legibilidade e arquitetura são tão importantes quanto o funcionamento imediato.

