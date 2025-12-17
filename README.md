---

# 🧾 Teste Técnico Delphi (Pedidos de Venda)

Este projeto foi desenvolvido como parte de um **teste técnico para vaga de Desenvolvedor Delphi**, com o objetivo de demonstrar conhecimentos em **POO, MVC, Clean Code, SQL e FireDAC**, seguindo os requisitos.

O sistema consiste em uma **tela de pedidos de venda**, permitindo a seleção de cliente, inclusão/edição/exclusão de produtos, totalização do pedido e gravação dos dados no banco de dados MySQL.

---

## 🎯 Objetivos do Projeto

* Demonstrar domínio da linguagem **Delphi**
* Aplicar conceitos de **Orientação a Objetos**
* Separar responsabilidades utilizando **MVC**
* Utilizar **FireDAC** para acesso ao banco de dados
* Trabalhar com **SQL explícito** (SELECT, INSERT, UPDATE, DELETE)
* Implementar **transações** para garantir integridade dos dados
* Organizar o projeto de forma clara e legível

---

## 🧱 Arquitetura

O projeto foi estruturado seguindo uma abordagem **MVC simplificada**, com separação clara entre:

* **View (Forms)**
  Responsáveis pela interação com o usuário e exibição dos dados.

* **Controller**
  Responsáveis por orquestrar o fluxo da aplicação, validações básicas e controle de transações.

* **DAO (Data Access Object)**
  Responsáveis exclusivamente pelo acesso ao banco de dados via FireDAC e SQL explícito.

* **Model**
  Classes que representam as entidades do domínio (Cliente, Produto, Pedido e Itens do Pedido).

Essa separação facilita a leitura, manutenção e evolução do código.

---

## 🗄️ Banco de Dados

* **MySQL**
* Estrutura composta por:

  * `clientes`
  * `produtos`
  * `pedidos_venda`
  * `pedidos_venda_itens`
* Uso de:

  * **Chaves primárias e estrangeiras**
  * **Índices**
  * **Relacionamentos**
* Script/DUMP do banco disponível no diretório raiz do projeto

---

## 🧩 Funcionalidades Implementadas

* Seleção de cliente (cadastro pré-existente)
* Inclusão de produtos no pedido informando:

  * Código do produto
  * Quantidade
  * Valor unitário
* Grid de itens do pedido com:

  * Código
  * Descrição
  * Quantidade
  * Valor unitário
  * Valor total
* Edição de itens via navegação no grid
* Exclusão de itens com confirmação
* Permite produtos repetidos no pedido
* Totalização automática do pedido
* Gravação do pedido e seus itens em tabelas separadas
* Uso de **transações** para garantir consistência dos dados
* Carregamento e exclusão de pedidos já gravados

---

## 🔧 Tecnologias Utilizadas

* **Delphi**
* **FireDAC**
* **MySQL**
* SQL nativo (sem ORMs ou componentes de terceiros)
* Arquivo `.ini` para configuração dinâmica de conexão com o banco

---

## 📌 Observações

Este projeto foi desenvolvido dentro de um **prazo limitado**, priorizando:

* Funcionamento
* Clareza de código
* Organização
* Boas práticas

Alguns pontos podem ser refinados em uma evolução futura, como desacoplamento adicional entre camadas e melhorias pontuais de validação, sem impactar o funcionamento geral do sistema.

---

## 👨‍💻 Autor

**Claudio Colares**
Desenvolvedor Delphi
---

