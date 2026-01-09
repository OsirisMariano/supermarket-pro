class Calculadora
  def self.aplicar_desconto(preco, porcentagem)
    return 0.0 unless preco.is_a?(Numeric) && porcentagem.is_a?(Numeric)
    valor_de_desconto = preco * (porcentagem / 100.0)
    resultado = preco - valor_de_desconto

    resultado < 0 ? 0.0 : resultado
  end
end