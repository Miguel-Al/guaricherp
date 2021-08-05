# coding: iso-8859-1
require 'prawn/table'
class FacturaVentaPdf < Prawn::Document
  def initialize(venta, empresa)
    super()
    @empresa = empresa
    @venta = venta
    titulo
    listado
    final
  end

  def titulo
    bounding_box([0, cursor], width: 400, height: 80) do
      text "#{@empresa.nombre_empresa.upcase}", size: 20, style: :bold, align: :center
      text "#{@empresa.direccion_empresa.upcase}", size: 10, style: :bold, align: :center
      text "Telf: #{@empresa.telefono_empresa}", size: 10, style: :bold, align: :center
      bounding_box([400, bounds.top], width: 140) do
        move_down 5
        text "RIF:", size: 10, style: :bold, align: :center
        text "J-#{@empresa.rif_empresa}", size: 10, style: :bold, align: :center
        text "Fecha:", size: 10, style: :bold, align: :center
        text "#{@venta.created_at.strftime("%d-%m-%Y")}", size: 10, style: :bold, align: :center
        text "Vendedor: #{@venta.user.username.upcase}", size: 12, style: :bold, align: :center
        transparent(0.5) { stroke_bounds }
      end
    end
    move_down 20
    ficha = [["N° de venta: #{@venta.numero_venta}", "N° de control:#{@empresa.numero_control}"]]
    table(ficha) do
      cells.border_color = "FFFFFF"
      cells.font_style = :bold
      cells.size = 20
      cells.width = 270
    end
    move_down 5
      bounding_box([0, cursor], width: 540) do
        move_down 5
        text "Nombre o Razon social: #{@venta.client.nombre_cliente.upcase}", size: 12, style: :bold, indent_paragraphs: 5
        text "RIF: #{@venta.client.rif_cliente}", size: 12, style: :bold, indent_paragraphs: 5
        text "Direccion Fiscal: #{@venta.client.direccion_cliente.upcase}", size: 12, style: :bold, indent_paragraphs: 5
        text "Telefono: #{@venta.client.phoneclients.first.try(:numero_cliente)}", size: 12, style: :bold, indent_paragraphs: 5
        transparent(0.5) { stroke_bounds }
      end
    move_down 5
  end

  def listado
    move_down 10
    table(item_table_data) do
      row(0).font_style = :bold
      row(0).background_color = "DDDDDD"
      self.header = true
      self.row_colors = ['FFFFFF']
      self.column_widths = [265, 65, 95, 115]
      cells.border_width = 2
      cells.align = :center
    end
  end

  def item_header
  ["Producto", "Cantidad", "Precio", "Total"]
end

def item_rows
  @venta.sale_details.map do |detalle|
    [detalle.product.nombre_producto, detalle.cantidad, "#{detalle.precio_detalle_venta}",  "#{detalle.precio_detalle_venta * detalle.cantidad}"]
  end
end

def item_table_data
  [item_header, *item_rows] 
end

def final
  bounding_box([0, cursor], width: 100, height: 125) do
    move_down 10
    text"Forma de pago:", style: :bold, align: :center
    text "#{@venta.type_payment.nombre_tipo_pago.upcase}", align: :center
    bounding_box([100, bounds.top], width: 440) do
      move_down 10
      text "El subtotal de venta: Bs #{@venta.total_venta}", size: 15, style: :bold, align: :right
      text "El 16% del IVA : Bs #{@venta.total_venta * 0.16}", size: 15, style: :bold, align: :right
      text "El total de venta: Bs #{@venta.total_venta * 1.16}", size: 15, style: :bold, align: :right
    end
    end
end
end


  

