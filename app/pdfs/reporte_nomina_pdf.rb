require 'prawn/table'
class ReporteNominaPdf < Prawn::Document
  def initialize(nominas)
    super()
    @nominas = nominas
    @minimo = nominas.minimum("inicio_nomina")
    @maximo = nominas.maximum("fin_nomina")
    @asignado = nominas.sum(:salario_nomina)
    @deduccion = nominas.sum(:salario_nomina)
    @total = nominas.sum(:salario_nomina)
    titulo
    listado
    total_asignado
  end

  def titulo
    text "Listado de los pagos de nominas realizados entre #{@minimo} y #{@maximo}", size: 10, style: :bold
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
    ["Empleado", "Asignado", "Deduccido", "Total"]
  end

  def item_rows
    @nominas.map do |nomina|
      [nomina.employee.nombre_apellido, nomina.abonacion, ((nomina.salario_nomina * 0.04) + (nomina.salario_nomina * 0.005) + (nomina.salario_nomina * 0.01)), nomina.total_final]
    end
  end

def item_table_data
  [item_header, *item_rows] 
end

def total_asignado
  span(310, position: :right) do
    text "Total de asignaciones: #{@asignado}"
  end
end

def total_deducido
  span(310, position: :right) do
    text "Total vendido en el periodo ha sido de: #{@ventas.all.sum(:total_venta) * 1.16}"
  end
end

def total
  span(310, position: :right) do
    text "Total vendido en el periodo ha sido de: #{@ventas.all.sum(:total_venta) * 1.16}"
  end
end


end
