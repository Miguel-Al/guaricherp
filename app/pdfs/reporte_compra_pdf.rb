require 'prawn/table'
class ReporteCompraPdf < Prawn::Document
  def initialize(compras, empresa)
    super :page_size => "LEGAL", :page_layout => :landscape
    @compras = compras
    @empresa = empresa
    titulo
    listado
    total
  end

  def titulo
    text "#{@empresa.nombre_empresa.upcase}", style: :bold
    text "RIF: J-#{@empresa.rif_empresa}", style: :bold
    text "Direccion: #{@empresa.direccion_empresa.upcase}", style: :bold
    text "Telf: #{@empresa.telefono_empresa}", style: :bold
    move_down 20
    text "Listado de compras realizadas entre #{@compras.last.created_at.strftime("%d-%m-%Y")} y #{@compras.first.created_at.strftime("%d-%m-%Y")}", size: 25, style: :bold
    move_down 5
    text "Este documento ha sido generado el dia #{DateTime.now.to_s(:db)}"
  end

  def listado
    move_down 10
    table(item_table_data) do
      row(0).font_style = :bold
      row(0).background_color = "DDDDDD"
      self.header = true
      self.row_colors = ['FFFFFF']
      self.column_widths = [90, 90, 200, 150, 150]
    end
  end

  def item_header
  ["#N compra", "Fecha", "Proveedor", "Base Imponible", "Total pagado"]
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
