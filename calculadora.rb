def limpar_tela
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

def salvar_csv(preco, desconto, resultado)
  data_hora = Time.now.strftime("%d/%m/%Y %H:%M")
  linha_csv = "#{data_hora};#{preco};#{desconto};#{format('%.2f', resultado)}"
  File.open("vendas.csv", "a") do |arquivo|
    arquivo.puts linha_csv
  end
end

def executar_vendas
  loop do
    limpar_tela
    puts " --- Área de Vendas ---"
    
    preco = pedir_numero("Digite o preço do produto: ")
    desconto = pedir_numero("Digite a porcentagem do desconto (%): ")
    resultado = Calculadora.aplicar_desconto(preco, desconto)
        
    salvar_log(preco, desconto, resultado)
    salvar_csv(preco, desconto, resultado)
        
    print "\nDeseja realizar outro cálculo? (S/N): "
    decisao = gets.chomp.downcase
        
    if decisao != 's' && decisao != 'sim'
      break
    end
  end
end

def exibir_relatorio
  limpar_tela
  puts " === RELATÓRIO DE FATURAMENTO ==="
  unless File.exist?("vendas.csv")
    print "\nPressione Enter para voltar."
    gets
    return
  end

  faturamento_total = 0.0

  File.foreach("vendas.csv") do |linha|
    dados = linha.split(";")
    valor_venda = dados[3].to_f
    faturamento_total += valor_venda
    puts "Venda: R$#{format('%.2f', valor_venda)} em #{dados[0]}"
  end

  puts "=========================================="
  puts "FATURAMENTO TOTAL: R$ #{format('%.2f', faturamento_total)}"
  puts "=========================================="
  print "\nPressione Enter para voltar ao menu"
  gets
end

# --- INÍCIO DA EXECUÇÃO ---
loop do
  limpar_tela
  puts " --- Menu Principal ---"
  puts "1. Nova Venda"
  puts "2. Ver Relatório de Fatuarmento"
  puts "3. Sair"
  print "Escolha uma opção: "

  opcao = gets.chomp

  case opcao
  when "1"
    executar_vendas
  when "2"
    exibir_relatorio
    # print "Pressione Enter para voltar."
    gets
  when "3"
    puts "Encerramento sistema... Até logo!"
    break
  else
    puts "Opção inválida."
    sleep 1
  end
end