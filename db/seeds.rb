puts "🧹 Limpando o banco de dados..."
Tagging.destroy_all
Board.destroy_all
Tag.destroy_all
User.destroy_all

puts "👤 Criando usuário de teste..."
user = User.create!(
  email: "test@example.com",
  password: "password",
  password_confirmation: "password"
)

puts "🏷️ Criando tags..."
colors = %w[#F87171 #60A5FA #34D399 #FBBF24 #A78BFA #F472B6]
titles = %w[Urgente Backend Frontend Bug Pessoal Trabalho]

tags = titles.each_with_index.map do |title, i|
  Tag.create!(title: title, color: colors[i % colors.length])
end

puts "📋 Criando boards com tags..."
5.times do |i|
  board = Board.create!(
    name: "Board #{i + 1}",
    description: "Este é o board número #{i + 1}",
    banner: nil,
    user: user
  )

  # Adiciona de 2 a 4 tags aleatórias
  board.tags << tags.sample(rand(2..4))
end

puts "✅ Seeds criados com sucesso!"
puts "🔑 Usuário de teste:"
puts "   Email:    test@example.com"
puts "   Senha:    password"
