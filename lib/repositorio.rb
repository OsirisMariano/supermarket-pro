class Repositorio

  # Cores para relatório
  VERDE = "\e[32m"
  VERMELHO = "\e[31m"
  CIANO = "\e[36m"
  RESET = "\e[0m"

  def self.salvar_log(produto, preco, resultado)
    data_hora = Time.now.strftime("%d/%m/%Y %H:%M")
    File.open("Vendas.log", "a") do |arquivo|
      arquivo.puts "[#{data_hora}] Produto: #{produto} | Preço:#{preco} | Total: #{format('.2f', resultado)}"
    end
  end

  def self.salvar_csv(produto, preco, desconto, resultado)
    data_hora = Time.now.strftime("%d/%m/%Y %H:%M")
    linha_csv = "#{data_hora};#{produto};#{preco};#{desconto};#{format('%.2f', resultado)}"

    File.open("vendas.csv", "a") do | arquivo|
      arquivo.puts linha_csv
    end
  end

  def self.exibir_relatorio
    system('cls') || system('clear')

    puts " #{CIANO}#{"=== RELATÓRIO DE FATURAMENTO ===".center(65)}#{RESET}"
    
    unless File.exist?("vendas.csv")
      puts "\n#{VERMELHO}Nenhuma venda registrada até o momento.#{RESET}"
      print "\nPressione Enter para voltar."
      gets
      return
    end

    puts "\n" + "DATA".ljust(20) + " | "+ "PRODUTO".ljust(20) + " | " + "TOTAL DE VENDA".ljust(15)
    puts "_" * 65

    faturamento = 0.0

    File.foreach("vendas.csv") do |linha|
      next if linha.strip.empty?
      dados = linha.split(";")

      data_venda    = dados[0]
      nome_item     = dados[1]
      valor_final   = dados[4].to_f

      faturamento   += valor_final

      # puts "#{data_vendas.ljust(20)} | #{VERDE}R$ #{format('%.2f', valor_vendas).ljsut(12)}#{RESET}"
      puts "#{data_venda.ljust(20)} | #{nome_item.ljust(20)} | #{VERDE}R$ #{format('%.2f', valor_final).ljust(12)}#{RESET}"
    end

    puts "_" *65
    puts "#{'FATURAMENTO TOTAL:'.ljust(43)} | #{VERDE}R$ #{format('%.2f', faturamento).ljust(12)}#{RESET}"
    puts "="*65
    print "\nPressione Enter para voltar ao menu"
    gets
  end
end