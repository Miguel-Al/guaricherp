require 'prawn/table'
class ReporteVentaPdf < Prawn::Document
  def initialize(ventasdocu, empresa)
    super :page_size => "LEGAL", :page_layout => :landscape
    @ventas = ventasdocu
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
    text "Listado de ventas realizadas entre #{@ventas.last.created_at.strftime("%d-%m-%Y")} y #{@ventas.first.created_at.strftime("%d-%m-%Y")}", size: 25, style: :bold
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
  ["#N de venta", "Fecha", "Cliente", "Base Imponible", "Total"]
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
