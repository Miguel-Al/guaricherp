# coding: iso-8859-1
require 'prawn/table'
class RegistroCompraPdf < Prawn::Document
  def initialize(compra, empresa)
    super()
    @empresa = empresa
    @compra = compra
    titulo
    listado
    subtotal
    iva
    total
  end

  def titulo
    text "#{@empresa.nombre_empresa.upcase}", size: 20, style: :bold
    text_box "N° de la factura:", at: [385, 715]
    text_box "#{@compra.numero_compra}", at: [385, 700] 
    move_down 20
    text "REGISTRO DE COMPRA", size: 15, style: :bold, align: :center
    move_down 10
    text "Nombre o Razon social: #{@compra.supplier.nombre_proveedor.upcase}", size: 12, style: :bold
    text "RIF: #{@compra.supplier.rif_proveedor}", size: 12, style: :bold
    text "Direccion Fiscal: #{@compra.supplier.direccion_proveedor.upcase}", size: 12, style: :bold
    text "Telefono: #{@compra.supplier.phonesuppliers.first.try(:numero_proveedor)}", size: 12, style: :bold
    move_down 10
    text "Encargado de registro: #{@compra.user.username.upcase}", size: 15, style: :bold
    text "Fecha de registro: #{@compra.created_at.strftime("%d-%m-%Y")}", size: 15, style: :bold
  end

  def listado
    move_down 5
    text "Productos comprados", size: 15, style: :bold
    table(item_table_data, :cell_style => {:border_color => "FFFFFF"}) do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [200, 80, 200, 60]
    end
    move_down 20
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
  text "El subtotal de la compra fue : Bs #{@compra.total_compra}", size: 15, style: :bold, align: :right
end
def iva
  text "16% del IVA : Bs #{@compra.total_compra * 0.16}", size: 15, style: :bold, align: :right
end
def total
  text "El total de la compra fue: Bs #{@compra.total_compra * 1.16}", size: 15, style: :bold, align: :right
end
end
