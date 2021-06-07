require 'prawn/table'
class ReporteInventarioPdf < Prawn::Document
  def initialize(productos)
    super()
    @productos = productos
    titulo
    listado
  end

  def titulo
    text "Listado Del inventario #{DateTime.now.to_s(:db)}", size: 15, style: :bold
  end

  
 def listado
    table product_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [80, 260, 200]
    end
  end

  def product_rows
    [['Codigo #', 'Nombre del producto', 'Existencia actual']] +
      @productos.map do |product|
      [product.codigo_producto, product.nombre_producto, product.existencia_producto]
    end * 20
  end

end
