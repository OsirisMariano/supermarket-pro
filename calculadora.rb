require_relative 'lib/calculadora'
require_relative 'lib/repositorio'

VERDE = "\e[32m"
VERMELHO = "\e[31m"
CIANO = "\e[36m"
RESET = "\e[0m"

# --- MÉTODOS DE INTERFACE ---
def limpar_tela
  Gem.win_platform? ? system('cls') : system('clear')
end

def pedir_texto(mensagem)
  loop do
    print mensagem
    entrada = gets.chomp.strip
    return entrada unless entrada.empty?
    puts "#{VERMELHO} O nome do produto não pode ficar em branco.#{RESET}"
  end
end

def pedir_numero(mensagem)
  loop do
    print mensagem
    entrada = gets.chomp.gsub(',' , '.')
    begin
      numero = Float(entrada)
      if numero < 0
        puts "Erro: O valor não pode ser negativo."
        next
      end
      return numero
    rescue ArgumentError
      puts "Erro: '#{entrada}' não é um número válido. Tente novamente."
    end
  end
end

def executar_vendas
  loop do
    limpar_tela
    puts " --- Área de Vendas ---"
    
    nome_produto = pedir_texto("Nome do Produto: ")
    
    preco = pedir_numero("Digite o preço do produto: ")
    desconto = pedir_numero("Digite a porcentagem do desconto (%): ")
    
    resultado = Calculadora.aplicar_desconto(preco, desconto)
    
    puts "=========================================="
    puts "#{VERDE}Sucesso!#{RESET} Produto: #{CIANO}#{nome_produto}#{RESET} Valor final: #{VERDE}R$ #{format('%.2f', resultado)}#{RESET}"
    
    Repositorio.salvar_log(nome_produto, preco, resultado)
    Repositorio.salvar_csv(nome_produto, preco, desconto, resultado)

    print "\nDeseja realizar outro cálculo? (S/N): "
    decisao = gets.chomp.downcase
        
    break unless ['s', 'sim'].include?(decisao)
  end
end

# --- INÍCIO DA EXECUÇÃO ---

loop do
  limpar_tela
  puts " --- Menu Principal ---"
  puts "#{CIANO}========================================"
  puts " SUPERMARKET v2.0"
  puts "========================================#{RESET}"
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