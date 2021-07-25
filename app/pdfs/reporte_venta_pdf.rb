require 'prawn/table'
class ReporteVentaPdf < Prawn::Document
  def initialize(ventasdocu)
    super :page_size => "A4", :page_layout => :landscape
    @ventas = ventasdocu
    titulo
    listado
    total
  end

  def titulo
    text "Listado de ventas realizadas entre #{@ventas.last.created_at.strftime("%d-%m-%Y")} y #{@ventas.first.created_at.strftime("%d-%m-%Y")}", size: 25, style: :bold
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
  ["#N de venta", "Fecha", "Cliente", "Base Imponible", "Total pagado"]
end

def item_rows
  @ventas.map do |venta|
    [venta.numero_venta, venta.created_at.strftime("%d-%m-%Y") , venta.client.nombre_cliente, "Bs #{venta.total_venta}", "Bs #{venta.total_venta * 1.16}"]
  end
end

def item_table_data
  [item_header, *item_rows] 
end

def total
  move_down 20
  text "Total vendido en el periodo: Bs #{@ventas.all.sum(:total_venta) * 1.16}", size: 15, style: :bold
end

end
