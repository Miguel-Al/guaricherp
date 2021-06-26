# coding: iso-8859-1
require 'prawn/table'
class FacturaVentaPdf < Prawn::Document
  def initialize(venta, empresa)
    super()
    @empresa = empresa
    @venta = venta
    titulo
    listado
    subtotal
    iva
    total
  end

  def titulo
    text "#{@empresa.nombre_empresa}"
    text "#{@empresa.direccion_empresa}"
    text "Telf: #{@empresa.telefono_empresa}"
    text "N° de control:#{@empresa.numero_control}"
    
    text "Nombre o Razon social: #{@venta.client.nombre_cliente}"
    text "RIF: #{@venta.client.rif_cliente}"
    text "Telefono: #{@venta.client.phoneclients.first.try(:numero_cliente)}"
    text "Direccion Fiscal: #{@venta.client.direccion_cliente}"

    text "Vendedor: #{@venta.user.username}"
    text "Este documento ha sido generado el dia #{DateTime.now.to_s(:db)}"
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
  @venta.sale_details.map do |detalle|
    [detalle.product.nombre_producto, detalle.cantidad, "Bs #{detalle.precio_detalle_venta}",  "Bs #{detalle.precio_detalle_venta * detalle.cantidad}"]
  end
end

def item_table_data
  [item_header, *item_rows] 
end
def subtotal
  text "El subtotal de la venta es : Bs #{@venta.total_venta}"
end
def iva
  text "El 16% del iva es : Bs #{@venta.total_venta * 0.16}"
end
def total
  text "El total de la venta es : Bs #{@venta.total_venta * 1.16}"
end
end
