require 'prawn/table'
class ReporteNominaPdf < Prawn::Document
  def initialize(nominas, empresa)
    super :page_size => "LEGAL", :page_layout => :landscape
    @empresa = empresa
    @nominas = nominas
    @minimo = nominas.minimum("inicio_nomina")
    @max = nominas.maximum("fin_nomina")
    @asigna = ((nominas.sum(:salario_nomina)) + (nominas.sum(:alimento_cesta)))
    @deduce = ((nominas.sum(:salario_empleado) * 0.04) + (nominas.sum(:salario_empleado) * 0.005) + (nominas.sum(:salario_empleado) * 0.01) + (nominas.sum(:adelanto_nomina)) )

    titulo
    listado
    total_asignado
    total_deducido
    total
  end

  def titulo
    text "#{@empresa.nombre_empresa.upcase}", style: :bold
    text "RIF: J-#{@empresa.rif_empresa}", style: :bold
    text "Direccion: #{@empresa.direccion_empresa.upcase}", style: :bold
    text "Telf: #{@empresa.telefono_empresa}", style: :bold
    move_down 20
    text "Resumen de nomina del periodo #{@minimo.strftime("%d-%m-%Y")} y #{@max.strftime("%d-%m-%Y")}", size: 25, style: :bold
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
    end
  end

  def item_header
    ["Empleado", "Salario \n Devengado", "Cesta \n Ticket", "Total \n Asignaciones", "S.S.O", "L.R.P.E", "F.A.O.V", "Adelanto", "Total \n Deducciones", "Total"]
  end
  
  def item_rows
    @nominas.map do |nomina|
      [nomina.employee.nombre_apellido, "Bs #{nomina.salario_nomina}", "Bs #{nomina.alimento_cesta}", "Bs #{(nomina.salario_nomina + nomina.alimento_cesta)}", "Bs #{(nomina.salario_empleado * 0.04)}", "Bs #{(nomina.salario_empleado * 0.005)}", "Bs #{(nomina.salario_empleado * 0.01)}", "Bs #{nomina.adelanto_nomina}", "Bs #{((nomina.salario_empleado * 0.04) + (nomina.salario_empleado * 0.005) + (nomina.salario_empleado * 0.01) + nomina.adelanto_nomina)}", "Bs #{(nomina.salario_nomina + nomina.alimento_cesta) - ((nomina.employee.salario_empleado * 0.04) + (nomina.employee.salario_empleado * 0.005) + (nomina.employee.salario_empleado * 0.01) + nomina.adelanto_nomina)}"]
    end
  end

def item_table_data
  [item_header, *item_rows] 
end

def total_asignado
  move_down 20
  text "Total de Asignaciones: Bs #{@asigna}", size: 15, style: :bold
end

def total_deducido
  text "Total de Deducciones: Bs #{(@deduce).round(2)}", size: 15, style: :bold
end

def total
  text "Total del Periodo: Bs #{((@asigna) - (@deduce)).round(2)}", size: 15, style: :bold
end


end
