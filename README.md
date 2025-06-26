<h2 align="center">
  ToDoThat - Sua Vida Mais Fácil
</h2>

<hr>

## Sumário
1. [O que é o ToDoThat?](#descrição)
2. [Decisões Técnicas](#decisões-técnicas)
3. [Diferenciais](#diferenciais)
4. [Requisitos](#requisitos)
   - [Funcionalidades Principais](#funcionalidades-principais)
   - [Quadros de Tarefas](#quadros-de-tarefas)
   - [Você e Seus Resultados](#resultados)
   - [Usuário e Autenticação](#usuário-e-autenticação)
5. [Requisitos em Formato de Imagem e Tutorial de uso da Aplicação](#requisitos-em-formato-de-imagem-e-tutorial-de-uso-da-aplicação)
6. [Considerações](#considerações)
7. [Banco de Dados](#informações-de-banco-de-dados)
8. [Decisões de Projeto e Práticas Utilizadas](#decisões-de-projeto-e-práticas-utilizadas)
9. [Autores](#autores)
10. [Agradecimentos](#agradecimentos)
11. [Link da Aplicação](#link-da-aplicação)

---

## O que é o ToDoThat?

O **ToDoThat** é um aplicativo de organização pessoal pensado para facilitar a sua rotina de maneira prática, visual e eficiente. 

Com ele, você pode:

- Gerenciar tarefas de qualquer natureza: desde projetos profissionais complexos até listas simples do dia a dia.
- Acompanhar o seu progresso ao longo do tempo.
- Gerar métricas úteis para entender como anda sua produtividade.
- Organizar tudo do seu jeito: defina prioridades, tags, prazos e personalize o que quiser ver nos quadros.

A ideia central do ToDoThat é que você tenha controle e clareza sobre o que precisa fazer, sem complicações, com uma interface intuitiva e recursos que realmente fazem diferença na hora de se organizar.

---

## Decisões Técnicas

- **Linguagem Principal**: Ruby 3.4.4
- **Framework**: Ruby on Rails 8.0.2
- **Banco de Dados**: PostgreSQL
- **Frontend**: TailwindCSS, DaisyUI
- **Autenticação**: Devise + Omniauth
- **Componentes da Hotwire**: Turbo + Stimulus

---

## Diferenciais
O ToDoThat vai além de uma simples lista de tarefas. Ele oferece uma experiência completa de organização, planejamento e análise do seu dia a dia. Aqui estão alguns dos principais diferenciais da aplicação:

✅ Autenticação via Google
Login rápido, seguro e sem complicações com integração à conta Google.

🏷️ Tags personalizadas para tarefas
Crie e organize suas tarefas com tags totalmente personalizáveis, facilitando filtros e visualizações específicas.

🧩 Quadros customizáveis
Organize suas tarefas em diferentes quadros (boards) com colunas (estágios) ajustáveis, como "A Fazer", "Em Progresso", "Concluído", ou qualquer outro que você desejar.

📅 Tarefas com data de vencimento e prioridade
Adicione prazos e defina níveis de prioridade para manter o foco no que realmente importa.

📈 Resumo gráfico do seu progresso
Acompanhe visualmente como anda sua produtividade com gráficos simples e intuitivos.

---

## Considerações


---


---

## Decisões de Projeto e Práticas Utilizadas

1. **Partial Views**
   - Divisão das views para reaproveitamento e clareza
2. **Service Objects**
   - Regras de negócio encapsuladas fora dos controllers
3. **Helpers**
   - Funções reutilizáveis como `format_date`
4. **Modularidade**
   - Código dividido por responsabilidade funcional (ex: `cards/edit`)
5. **Variáveis de Instância em Views**
   - Redução da lógica direta nos templates `.html.erb`
6. **Centralização de cores**
   - Arquivo global de cores para facilitar customização

---

## Autores

- [Seu Nome Aqui]

---

## Agradecimentos

- Projeto desenvolvido com 💙, focado em tornar o cotidiano mais leve e produtivo.

---

## Link da Aplicação

[Clique aqui para acessar a aplicação! 🚀](https://todo-do-project.onrender.com/)
