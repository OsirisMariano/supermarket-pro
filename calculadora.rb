class Calculadora
  def self.aplicar_desconto(preco, porcentagem)
    return 0 unless preco.is_a?(Numeric) && porcentagem.is_a?(Numeric)
    valor_de_desconto = preco * (porcentagem / 100.0)
  end
end

loop do
  puts "\n--- Supermarket Pro: (Módulo de Desconto) ---"
  puts "Dica: Digite 'sair' no preço para encerrar."
  
  print "Digite o preço do produto: "
  entrada_preco = gets.chomp.downcase
  
  # CONDIÇÃO DE SAÍDA:
  break if entrada_preco == 'sair'
  
  preco = entrada_preco.to_f
  
  print "Digite a percentagem de desconto (%): "
  desconto = gets.chomp.to_f

  resultado = Calculadora.aplicar_desconto(preco, desconto)

  puts "-------------------------------"
  puts "✅ Sucesso! Valor final: R$ #{format('%.2f', resultado)}"
  puts "-------------------------------"
end

puts "Obrigado por usar o Supermarket Pro. Até logo!"