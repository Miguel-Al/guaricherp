require 'prawn/table'
class ReporteInventarioPdf < Prawn::Document
  def initialize(productos, empresa)
    super()
    @empresa = empresa
    @productos = productos
    titulo
    listado
  end

  def titulo
    text "#{@empresa.nombre_empresa}", size: 20, style: :bold, align: :center
    move_down 10
    text "Listado del inventario fecha: #{Date.today.to_s(:db)}", size: 20, style: :bold
    text "Este documento ha sido generado a las #{Time.now.to_s(:time)}", size: 10
  end

  
  def listado
    move_down 15
    table product_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [120, 280, 140]
    end
  end

  def product_rows
    [['Codigo #', 'Nombre del producto', 'Existencia actual']] +
      @productos.map do |product|
      [product.codigo_producto, product.nombre_producto, product.existencia_producto]
    end
  end

end
