class Repositorio

  # Cores para relatório
  VERDE = "\e[32m"
  VERMEHLO = "\e[31m"
  CIANO = "\e[36m"
  RESET = "\e[0m"

  def self.salvar_log(preco, desconto, resultado)
    data_hora = Time.now.strftime("%d/%m/%Y %H:%M")
    File.open("Vendas.log", "a") do |arquivo|
      arquivo.puts "[#{data_hora}] Venda: #{preco} | Desconto: #{desconto} | Total: #{format('.2f', resultado)}"
    end
  end

  def self.salvar_csv(preco, desconto, resultado)
    data_hora = Time.now.strftime("%d/%m/%Y %H:%M")
    linha_csv = "#{data_hora};#{preco};#{desconto};#{format('%.2f', resultado)}"
    File.open("vendas.csv", "a") do | arquivo|
      arquivo.puts linha_csv
    end
  end

  def self.exibir_relatorio
    Gem.win_platform? ? system('cls') : system('clear')

    puts " #{CIANO}=== RELATÓRIO DE FATURAMENTO ===#{RESET}"
    
    unless File.exist?("vendas.csv")
      puts "\n#{VERMEHLO}Nenhuma venda registrada até o momento.#{RESET}"
      print "\nPressione Enter para voltar."
      gets
      return
    end

    puts "\n" + "DATA".ljust(20) + " | " + "TOTAL DE VENDA".ljust(15)
    puts "_" * 40

    faturamento = 0.0

    File.foreach("vendas.csv") do |linha|
      next if linha.strip.empty?
      dados = linha.split(";")

      data_venda = dados[0]
      valor_venda = dados[3].to_f
      faturamento += valor_venda
      
      # puts "#{data_vendas.ljust(20)} | #{VERDE}R$ #{format('%.2f', valor_vendas).ljsut(12)}#{RESET}"
      puts "#{data_venda.ljust(20)} | #{VERDE}R$ #{format('%.2f', valor_venda).ljust(12)}#{RESET}"
    end

    puts "_" *40
    puts "#{'FATURAMENTO TOTAL:'.ljust(20)} | #{VERDE}R$ #{format('%.2f', faturamento).ljust(12)}#{RESET}"
    puts "=========================================="
    print "\nPressione Enter para voltar ao menu"
    gets
  end
end