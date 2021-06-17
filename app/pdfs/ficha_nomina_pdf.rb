require 'prawn/table'
class FichaNominaPdf < Prawn::Document
  def initialize(nomina)
    super()
    @nomina = nomina
    titulo
    listado
    subtotal
    iva
    total
  end
