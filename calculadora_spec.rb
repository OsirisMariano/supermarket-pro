require_relative 'calculadora'

def testar_desconto
  puts "🧪 Testando..."
  resultado = Calculadora.aplicar_desconto(100, 10) # Corrigi para aplicar_desconto
  
  if resultado == 90
    puts "✅ Teste passou!"
  else
    puts "❌ Teste falhou! Obtivemos #{resultado}."
  end
end

testar_desconto