require 'prawn/table'
class ReporteVentaPdf < Prawn::Document
  def initialize(ventas)
    super()
    @ventas = ventas
    titulo
    listado
    total
  end

  def titulo
    text "Listado de  las ventas realizadas entre #{@ventas.last.created_at.strftime("%d-%m-%Y")} y #{@ventas.first.created_at.strftime("%d-%m-%Y")}", size: 10, style: :bold
    text "Este documento ha sido generado el dia #{DateTime.now.to_s(:db)}", size: 10, style: :bold
  end

  def listado
    table(item_table_data, :cell_style => {:border_color => "FFFFFF"}) do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [80, 160, 200, 100]
    end
  end

  def item_header
  ["#N de venta", "Fecha", "Cliente", "Total pagado"]
end

def item_rows
  @ventas.map do |venta|
    [venta.id, venta.created_at.strftime("%d-%m-%Y") , venta.client.nombre_cliente, venta.total_venta * 1.16]
  end
end

def item_table_data
  [item_header, *item_rows] 
end

def total
  span(310, position: :right) do
    text "Total vendido en el periodo ha sido de: #{@ventas.all.sum(:total_venta) * 1.16}"
  end
end

end
