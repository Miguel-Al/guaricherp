require 'prawn/table'
class ReporteCompraPdf < Prawn::Document
  def initialize(compras)
    super :page_size => "A4", :page_layout => :landscape
    @compras = compras
    titulo
    listado
    total
  end

  def titulo
    text "Listado de compras realizadas entre #{@compras.last.created_at.strftime("%d-%m-%Y")} y #{@compras.first.created_at.strftime("%d-%m-%Y")}", size: 25, style: :bold
    text "Este documento ha sido generado el dia #{DateTime.now.to_s(:db)}"
  end

  def listado
    move_down 10
    table(item_table_data, :cell_style => {:border_color => "FFFFFF"}) do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [80, 100, 200, 150, 150]
    end
  end

  def item_header
  ["#N de compra", "Fecha", "Proveedor", "Base Imponible", "Total pagado"]
end

def item_rows
  @compras.map do |compra|
    [compra.numero_compra, compra.created_at.strftime("%d-%m-%Y"), compra.supplier.nombre_proveedor, "Bs #{compra.total_compra}", "Bs #{compra.total_compra * 1.16}"]
  end
end

def item_table_data
  [item_header, *item_rows] 
end

def total
  move_down 20
  text "Total comprado en el periodo: Bs #{@compras.all.sum(:total_compra) * 1.16}", size: 15, style: :bold
end

end
