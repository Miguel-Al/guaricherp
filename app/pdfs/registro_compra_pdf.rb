require 'prawn/table'
class RegistroCompraPdf < Prawn::Document
  def initialize(compra)
    super()
    @compra = compra
    titulo
    listado
    subtotal
    iva
    total
  end

  def titulo
    text "Proveedor: #{@compra.supplier.nombre_proveedor}"
    text "Encargado: #{@compra.user.username}"
  end

  def listado
    table(item_table_data, :cell_style => {:border_color => "FFFFFF"}) do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [200, 80, 200, 60]
    end
  end

  def item_header
  ["Producto", "Cantidad", "Precio", "Total"]
end

def item_rows
  @compra.purchase_details.map do |detalle|
    [detalle.product.nombre_producto, detalle.cantidad, "Bs #{detalle.precio_detalle_compra}",  "Bs #{detalle.precio_detalle_compra * detalle.cantidad}"]
  end
end

def item_table_data
  [item_header, *item_rows] 
end
def subtotal
  text "El subtotal de la compra fue : Bs #{@compra.total_compra}"
end
def iva
  text "16% del IVA : Bs #{@compra.total_compra * 0.16}"
end
def total
  text "El total de la compra fue: Bs #{@compra.total_compra * 1.16}"
end
end
