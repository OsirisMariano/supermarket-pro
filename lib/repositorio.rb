class Repositorio
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

    puts " === RELATÓRIO DE FATURAMENTO ==="
    
    unless File.exist?("vendas.csv")
      puts "\nNenhuma venda registrada até o momento."
      print "\nPressione Enter para voltar."
      gets
      return
    end

    faturamento = 0.0

    File.foreach("vendas.csv") do |linha|
      next if linha.strip.empty?

      dados = linha.split(";")
      valor_vendas = dados[3].to_f
      faturamento += valor_vendas
      puts "Vendas: R$ #{format('%.2f', valor_vendas)} | Data: #{dados[0]}"
    end

    puts "=========================================="
    puts "FATURAMENTO TOTAL: R$ #{format('%.2f', faturamento)}"
    puts "=========================================="
    print "\nPressione Enter para voltar ao menu"
    gets
  end
end