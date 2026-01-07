def limpar_tela
  # No Windows o comando é 'cls', no Linux/Mac é 'clear'
  Gem.win_platform? ? system('cls') : system('clear')
end
class Calculadora
  def self.aplicar_desconto(preco, porcentagem)
    return 0 unless preco.is_a?(Numeric) && porcentagem.is_a?(Numeric)
    valor_de_desconto = preco * (porcentagem / 100.0)
    preco - valor_de_desconto
  end
end
def pedir_numero(mensagem)
  loop do
    print mensagem
    entrada = gets.chomp
    return entrada.to_f if entrada.match?(/^\d+(\.\d+)?$/)
    puts "Erro: '#{entrada}' não é um número válido."
  end
end

def salvar_log(preco, desconto, resultado)
  data_hora = Time.now.strftime("%d/%m/%Y %H:%M")

  File.open("vendas.log", "a") do |arquivo|
    arquivo.puts "[#{data_hora}] Venda: #{preco} | Desconto: #{desconto} | Total: #{format('%.2f', resultado)}"
  end
end
loop do
  limpar_tela
  puts "\n --- Supermarket Pro ---"
  preco     = pedir_numero("Digite o preço do produto: ")
  desconto  = pedir_numero("Digite a porcentagem do desconto (%): ")
  resultado = Calculadora.aplicar_desconto(preco, desconto)

  puts "-------------------------------------"
  puts "Sucesso! Valor final: #{format('%.2f', resultado)}"
  puts "-------------------------------------"
  
  salvar_log(preco, desconto, resultado)
  
  print "\n desenja realizar outro cálculo? (S/N): "
  decisao = gets.chomp.downcase

  if decisao == 'n' || decisao == 'não' || decisao == 'nao'
    puts "\nEncerrando o sistema... Áte logo!"
    break
    elsif decisao == 's' || decisao == 'sim'
      puts "Reiniciando..."
    else
      puts "Opção inválida, mas vou assuir que você quer sair por segurança."
      break
  end
end

