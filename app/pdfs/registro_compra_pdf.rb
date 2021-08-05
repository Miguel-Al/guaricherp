# coding: iso-8859-1
require 'prawn/table'
class RegistroCompraPdf < Prawn::Document
  def initialize(compra, empresa)
    super()
    @empresa = empresa
    @compra = compra
    titulo
    listado
    final
  end

  def titulo
    text "#{@empresa.nombre_empresa.upcase}", size: 20, style: :bold, align: :center
    move_down 5
    text "REGISTRO DE COMPRA", size: 15, style: :bold, align: :center
    move_down 10
    bounding_box([0, cursor], width: 440, height: 80) do
      text "Nombre o Razon social: #{@compra.supplier.nombre_proveedor.upcase}", size: 12, style: :bold
      text "RIF: #{@compra.supplier.rif_proveedor}", size: 12, style: :bold
      text "Direccion Fiscal: #{@compra.supplier.direccion_proveedor.upcase}", size: 12, style: :bold
      text "Telefono: #{@compra.supplier.phonesuppliers.first.try(:numero_proveedor)}", size: 12, style: :bold
      bounding_box([440, bounds.top], width: 100) do
        text"N° de la factura:", style: :bold, align: :center
        text "#{@compra.numero_compra}", align: :center
        transparent(0.5) { stroke_bounds }
      end
    end  
    move_down 10
    text "Encargado de registro: #{@compra.user.username.upcase}", size: 15, style: :bold
    text "Fecha de registro: #{@compra.created_at.strftime("%d-%m-%Y")}", size: 15, style: :bold
  end

  def listado
    move_down 10
    text "Productos comprados", size: 15, style: :bold, align: :center
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
  @compra.purchase_details.map do |detalle|
    [detalle.product.nombre_producto, detalle.cantidad, "#{detalle.precio_detalle_compra}",  "#{detalle.precio_detalle_compra * detalle.cantidad}"]
  end
end

def item_table_data
  [item_header, *item_rows] 
end

def final

  bounding_box([0, cursor], width: 100, height: 125) do
    move_down 10
    text"Forma de pago:", style: :bold, align: :center
    text "#{@compra.type_payment.nombre_tipo_pago.upcase}", align: :center
    bounding_box([100, bounds.top], width: 440) do
      move_down 10
      text "El subtotal de la compra fue : Bs #{@compra.total_compra}", size: 15, style: :bold, align: :right
      text "16% del IVA : Bs #{@compra.total_compra * 0.16}", size: 15, style: :bold, align: :right
      text "El total de la compra fue: Bs #{@compra.total_compra * 1.16}", size: 15, style: :bold, align: :right
    end
  end
end

  
end
