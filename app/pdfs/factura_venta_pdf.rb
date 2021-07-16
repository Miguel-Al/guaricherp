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
    text "#{@empresa.nombre_empresa}", size: 20, style: :bold
    text "Direccion: #{@empresa.direccion_empresa}", size: 10, style: :bold
    text "Telf: #{@empresa.telefono_empresa}", size: 10, style: :bold
    text_box "N° de venta: #{@venta.numero_venta}", at: [390, 700]
    text_box "N° de control:#{@empresa.numero_control}", at: [390, 685]
    move_down 5
    text "Nombre o Razon social: #{@venta.client.nombre_cliente}", size: 12, style: :bold
    text "RIF: #{@venta.client.rif_cliente}", size: 12, style: :bold
    text "Direccion Fiscal: #{@venta.client.direccion_cliente}", size: 12, style: :bold
    text "Telefono: #{@venta.client.phoneclients.first.try(:numero_cliente)}", size: 12, style: :bold
    move_down 2
    text "Vendedor: #{@venta.user.username}", size: 10, style: :bold
    text "Fecha: #{@venta.created_at.strftime("%d-%m-%Y")}", size: 10, style: :bold
  end

  def listado
    move_down 5
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
  move_down 10
  text "El subtotal de la venta es : Bs #{@venta.total_venta}", size: 15, style: :bold, align: :right
end
def iva
  text "El 16% del iva es : Bs #{@venta.total_venta * 0.16}", size: 15, style: :bold, align: :right
end
def total
  text "El total de la venta es : Bs #{@venta.total_venta * 1.16}", size: 15, style: :bold, align: :right
end
end
