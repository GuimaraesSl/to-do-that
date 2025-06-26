puts "🧹 Limpando o banco de dados..."
Tagging.destroy_all
Task.destroy_all
Column.destroy_all
Board.destroy_all
Tag.destroy_all
User.destroy_all

puts "👤 Criando usuário de teste..."
user = User.create!(
  email: "test@example.com",
  password: "password",
  password_confirmation: "password"
)

puts "🏷️ Criando tags globais..."
tags_pool = [
  [ "Urgente", "#F87171" ],
  [ "Backend", "#60A5FA" ],
  [ "Frontend", "#34D399" ],
  [ "Bug", "#FBBF24" ],
  [ "Pessoal", "#A78BFA" ],
  [ "Trabalho", "#F472B6" ]
].map { |title, color| Tag.create!(title: title, color: color) }

def create_task(attrs, column, tags_pool)
  task = column.tasks.create!(
    title: attrs[:title],
    description: Faker::Lorem.sentence,
    difficulty: attrs[:difficulty],
    priority: attrs[:priority],
    due_date: attrs[:due_date],
    concluded_at: attrs[:concluded_at],
    position: column.tasks.count
  )
  task.tags << tags_pool.sample(rand(1..3))
end

boards = {
  "Estudo de Engenharia de Software" => [
    { title: "Ler capítulo 3 de Engenharia de Requisitos", difficulty: 1, priority: 3, due_date: 3.days.from_now },
    { title: "Fazer resumo de Arquitetura de Software", difficulty: 2, priority: 2, due_date: 6.days.from_now },
    { title: "Apresentação sobre Scrum", difficulty: 2, priority: 1, concluded_at: 6.days.ago }
  ],
  "Case V360 - ToDoThat" => [
    { title: "Configurar autenticação com Devise", difficulty: 3, priority: 2, due_date: 3.days.from_now },
    { title: "Criar layout inicial com Tailwind", difficulty: 4, priority: 2, due_date: 8.days.from_now },
    { title: "Deploy da aplicação no Google Cloud", difficulty: 1, priority: 1, concluded_at: 7.days.ago }
  ],
  "UFC - Faculdade" => [
    { title: "Estudar para prova de Estrutura de Dados", difficulty: 4, priority: 1, due_date: 4.days.from_now },
    { title: "Entrega do trabalho de Sistemas Operacionais", difficulty: 3, priority: 2, due_date: 1.day.from_now },
    { title: "Atualizar portfólio no GitHub", difficulty: 1, priority: 3, concluded_at: 9.days.ago }
  ]
}

puts "📋 Criando boards com tasks..."
boards.each do |name, tasks|
  board = Board.create!(
    name: name,
    description: "Board sobre #{name.downcase}",
    user: user
  )

  board.columns.each do |column|
    relevant_tasks = tasks.select do |task|
      column.is_done_column ? task[:concluded_at].present? : task[:concluded_at].nil?
    end

    relevant_tasks.each do |task_attrs|
      create_task(task_attrs, column, tags_pool)
    end
  end
end

puts "✅ Seeds criados com sucesso!"
puts "🔑 Usuário de teste:"
puts "   Email:    test@example.com"
puts "   Senha:    password"
