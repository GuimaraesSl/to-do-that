# ToDoThat - Sua Vida Mais Fácil

## Sumário
- [O que é o ToDoThat?](#o-que-é-o-todothat)
- [Decisões Técnicas](#decisões-técnicas)
- [Diferenciais](#diferenciais)
- [Imagens](#imagens)
- [Considerações](#considerações)
- [Entidades do ToDoThat](#entidades-do-todothat)
- [Autores](#autores)
- [Agradecimentos](#agradecimentos)
- [Link da Aplicação](#link-da-aplicação)

---

## 💡 O que é o ToDoThat?

O **ToDoThat** é um aplicativo de organização pessoal pensado para facilitar a sua rotina de maneira prática, visual e eficiente. 

Com ele, você pode:

- Gerenciar tarefas de qualquer natureza: desde projetos profissionais complexos até listas simples do dia a dia.
- Acompanhar o seu progresso ao longo do tempo.
- Gerar métricas úteis para entender como anda sua produtividade.
- Organizar tudo do seu jeito: defina prioridades, tags, prazos e personalize o que quiser ver nos quadros.

A ideia central do ToDoThat é que você tenha controle e clareza sobre o que precisa fazer, sem complicações, com uma interface intuitiva e recursos que realmente fazem diferença na hora de se organizar.

[Veja meu GitHub Projects com as ideias que ainda tenho!! ✍️](https://github.com/users/GuimaraesSl/projects/1/views/1)

---

## 🛠️ Decisões Técnicas

- **Linguagem Principal**: [Ruby 3.4.4](https://www.ruby-lang.org/en/news/2024/11/26/ruby-3-4-4-released/)  
- **Framework**: [Ruby on Rails 8.0.2](https://rubyonrails.org/2024/12/12/Rails-8-0-2-has-been-released)  
- **Banco de Dados**: [PostgreSQL](https://www.postgresql.org/)  
- **Frontend**: [TailwindCSS](https://tailwindcss.com/), [DaisyUI](https://daisyui.com/)  
- **Autenticação**: [Devise](https://github.com/heartcombo/devise) + [Omniauth](https://github.com/omniauth/omniauth)  
- **Componentes da Hotwire**: [Turbo](https://turbo.hotwired.dev/) + [Stimulus](https://stimulus.hotwired.dev/)  

---

## ✨ Diferenciais

✅ **Autenticação via Google**  
Login rápido, seguro e sem complicações com integração à conta Google.

🏷️ **Tags personalizadas para tarefas**  
Crie e organize suas tarefas com tags totalmente personalizáveis, facilitando filtros e visualizações específicas.

🧩 **Quadros customizáveis**  
Organize suas tarefas em diferentes quadros com colunas ajustáveis como "A Fazer", "Em Progresso", "Concluído", ou qualquer outro que desejar.

📅 **Tarefas com data de vencimento e prioridade**  
Adicione prazos e defina níveis de prioridade para manter o foco no que realmente importa.

📈 **Resumo gráfico do seu progresso**  
Acompanhe visualmente como anda sua produtividade com gráficos simples e intuitivos.

---

## 🖼️ Imagens

![Dashboard](https://github.com/user-attachments/assets/0d5ff36e-bbb0-47aa-a027-fda153ee715d)  
![Task View](https://github.com/user-attachments/assets/f9744de1-828c-44a2-95a9-25c97df3ed6c)  
![Progress Chart](https://github.com/user-attachments/assets/c5b14a4c-a212-44af-9bf3-65cf7830c2f3)

---

## 🧠 Considerações

O ToDoThat foi construído com foco na organização pessoal prática, mas é altamente escalável e pode ser facilmente adaptado para equipes e contextos corporativos.

---

## 🗃️ Entidades do ToDoThat

### 👤 `users`
- Armazena informações dos usuários: `email`, `full_name`, `avatar_url`, etc.  
- Suporte a login via Google (`uid`, `provider`)  
- Cada usuário → N boards

---

### 📋 `boards`
- Quadro de organização que agrupa colunas e tarefas  
- Atributos: `name`, `description`, `banner`, `user_id`  
- Cada board → N columns

---

### 📁 `columns`
- Representa estágios de tarefas em um board  
- Campos: `name`, `position`, `is_done_column`  
- Cada column → N tasks

---

### ✅ `tasks`
- Tarefa em uma coluna com:  
  `title`, `description`, `difficulty`, `priority`, `due_date`, `concluded_at`  
- Relaciona-se com `column_id`  
- Pode ter várias tags via associação polimórfica

---

### 🏷️ `tags`
- Tags personalizadas: `title`, `color`  
- Relacionamento polimórfico com outras entidades (ex: tarefas)

---

### 🔗 `taggings` (Associação Polimórfica)
- Conecta `tags` a entidades diversas via:  
  `taggable_type`, `taggable_id`  
- Exemplo: associar uma tag a uma `task`

---

### 🔄 Relações Importantes

```plaintext
User 1 ────< Board 1 ────< Column 1 ────< Task >──── Tagging >──── Tag
                                           ^
                                (polimorfismo via taggable_type/id)
```

![ToDoThatDiagram](https://github.com/user-attachments/assets/0a6ec213-3826-4a2b-8520-944567bb53d6)


---

## Autores

- [Gabriel Al-Samir Guimarães Sales](https://github.com/your-github-username)

---

## Agradecimentos

- Projeto desenvolvido com 💙, focado em tornar o cotidiano mais leve e produtivo.

---

## Link da Aplicação

[Clique aqui para acessar a aplicação! 🚀](https://todothat.onrender.com)
