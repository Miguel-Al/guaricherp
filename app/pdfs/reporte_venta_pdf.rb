require 'prawn/table'
class ReporteVentaPdf < Prawn::Document
  def initialize(venta)
    super()
    @venta = venta
    titulo
  end

  def titulo
    text "#{@venta.client.nombre_cliente}"
  end
end
