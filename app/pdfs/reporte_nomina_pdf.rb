require 'prawn/table'
class ReporteNominaPdf < Prawn::Document
  def initialize(nominas)
    super :page_size => "A4", :page_layout => :landscape
    @nominas = nominas
    @minimo = nominas.minimum("inicio_nomina")
    @max = nominas.maximum("fin_nomina")
    @asigna = (nominas.sum(:salario_nomina))
    @deduce = (((nominas.sum(:salario_nomina) * 0.04) + (nominas.sum(:salario_nomina) * 0.005) + (nominas.sum(:salario_nomina) * 0.01)) * 2)

    titulo
    listado
    total_asignado
    total_deducido
    total
  end

  def titulo
    text "Listado de los pagos de nominas realizados entre #{@minimo} y #{@max}", size: 10, style: :bold
  end
  
  def listado
    table(item_table_data, :cell_style => {:border_color => "FFFFFF"}) do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
    end
  end

  def item_header
    ["Empleado", "Periodo", "Pago", "Cesta", "S.S.O", "L.R.P.E", "F.A.O.V", "Total Asignados", "Total Deducciones", "Total"]
  end
  
  def item_rows
    @nominas.map do |nomina|
      [nomina.employee.nombre_apellido, nomina.periodo, nomina.salario_nomina, nomina.salario_nomina, (nomina.employee.salario_empleado * 0.04), (nomina.employee.salario_empleado * 0.005), (nomina.employee.salario_empleado * 0.01), (nomina.salario_nomina * 2), ((nomina.employee.salario_empleado * 0.04) + (nomina.employee.salario_empleado * 0.005) + (nomina.employee.salario_empleado * 0.01)), (nomina.salario_nomina * 2) - ((nomina.employee.salario_empleado * 0.04) + (nomina.employee.salario_empleado * 0.005) + (nomina.employee.salario_empleado * 0.01))]
    end
  end

def item_table_data
  [item_header, *item_rows] 
end

def total_asignado
  span(310, position: :right) do
    text "Total de asignaciones: #{@asigna * 2}"
  end
end

def total_deducido
  span(310, position: :right) do
    text "Total de deducciones: #{@deduce}"
  end
end

def total
  span(310, position: :right) do
    text "Total de la nomina del periodo: #{(@asigna * 2) - (@deduce)}"
  end
end


end
