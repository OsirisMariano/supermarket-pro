require_relative 'lib/calculadora'
require_relative 'lib/repositorio'

# --- MÉTODOS DE INTERFACE ---
def limpar_tela
  Gem.win_platform? ? system('cls') : system('clear')
end

def pedir_numero(mensagem)
  loop do
    print mensagem
    entrada = gets.chomp
    return entrada.to_f if entrada.match?(/^\d+(\.\d+)?$/)
    puts "Erro: '#{entrada}' não é um número válido."
  end
end

def executar_vendas
  loop do
    limpar_tela
    puts " --- Área de Vendas ---"
    
    preco = pedir_numero("Digite o preço do produto: ")
    desconto = pedir_numero("Digite a porcentagem do desconto (%): ")
    
    resultado = Calculadora.aplicar_desconto(preco, desconto)
    
    puts "=========================================="
    puts "Sucesso! Valor final: R$ #{format('%.2f', resultado)}"
    Repositorio.salvar_log(preco, desconto, resultado)
    Repositorio.salvar_csv(preco, desconto, resultado)

    print "\nDeseja realizar outro cálculo? (S/N): "
    decisao = gets.chomp.downcase
        
    break if decisao != 's' && decisao != 'sim'
  end
end

# --- INÍCIO DA EXECUÇÃO ---

loop do
  limpar_tela
  puts " --- Menu Principal ---"
  puts "========================================"
  puts " SUPERMARKET v2.0"
  puts "========================================"
  puts "1. Nova Venda"
  puts "2. Relatorio de Faturamento"
  puts "3. Sair"
  print "Escolha uma opção: "
  opcao = gets.chomp

  case opcao
  when "1"
    executar_vendas
  when "2"
    Repositorio.exibir_relatorio
  when "3"
    puts "Encerrando Sistema... Até logo!"
    break
  else
    puts "Opção inválida."
    sleep 1
  end
end