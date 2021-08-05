require 'prawn/table'
class FichaNominaPdf < Prawn::Document
  def initialize(nomina, empresa)
    super()
    @empresa = empresa
    @nomina = nomina
    titulo
    listado
    firma
  end
end

def titulo
  text "#{@empresa.nombre_empresa.upcase}", size: 14, style: :bold, align: :center
  text "RIF: J-#{@empresa.rif_empresa}", size: 14, style: :bold, align: :center
  text "Direccion: #{@empresa.direccion_empresa.upcase}", size: 14, style: :bold, align: :center
  text "Telf: #{@empresa.telefono_empresa}", size: 14, style: :bold, align: :center
  move_down 5
  text "Nomina de pago del empleado #{@nomina.employee.nombre_apellido.upcase}", size: 14, style: :bold, align: :center
  text "Periodo #{@nomina.inicio_nomina.strftime("%d-%m-%Y")} - #{@nomina.fin_nomina.strftime("%d-%m-%Y")}", size: 12, style: :bold, align: :center
  move_down 10
  text "Este documento ha sido generado el dia #{DateTime.now.strftime("%d-%m-%Y")}", size: 12, align: :center
  end

  def listado
    move_down 10
    info = [["Empleado:", "Cedula:", "Cargo:" ],
            ["#{@nomina.employee.primer_nombre.upcase} #{@nomina.employee.primer_apellido.upcase}", @nomina.employee.numero_cedula, @nomina.employee.position.nombre_cargo.upcase ]]
    table(info) do
      self.column_widths = [250, 150, 140]
      self.row_colors = ['FFFFFF']
      row(0).font_style = :bold
      row(0).background_color = "DDDDDD"
    end

    info2 = [["Salario Mensual:", "Forma de Pago:", "Tipo de Nomina:"],
             ["Bs #{@nomina.employee.salario_empleado}", @nomina.type_payment.nombre_tipo_pago.upcase, @nomina.paycheck_type.tipo_nomina_nombre.upcase]]
    table(info2) do
      self.column_widths = [275, 125, 140]
      self.row_colors = ['FFFFFF']
      row(0).font_style = :bold
      row(0).background_color = "DDDDDD"
    end

    asignaciones = [["Asignaciones"]]
    table(asignaciones ,:cell_style => { :size => 18, :align => :center}) do
      self.column_widths = [540]
      self.row_colors = ['DDDDDD']
      row(0).font_style = :bold
    end

    asignaciones2 = [["Total dias trabajados:", "#{@nomina.dias_nomina} dias", "Bs #{(@nomina.salario_empleado / 30).round(2)} por dia", "Bs #{@nomina.salario_nomina}"]]
    table(asignaciones2) do
      self.column_widths = [150, 100, 145, 145]
    end

    asignaciones3 = [["Cesta Ticket", "Bs #{@nomina.alimento_cesta}"]]
    table(asignaciones3) do
      self.column_widths = [150, 390]
    end

    deducciones = [["Deducciones"]]
    table(deducciones ,:cell_style => { :size => 18, :align => :center}) do
      self.column_widths = [540]
      self.row_colors = ['DDDDDD']
      row(0).font_style = :bold
    end

    deducciones2 = [["S.S.O (4%)", "Bs #{@nomina.employee.salario_empleado * 0.04}"],
           ["L.R.P.E (0,5%)", "Bs #{@nomina.employee.salario_empleado * 0.005}"],
           ["F.A.O.V (1%)", "Bs #{@nomina.employee.salario_empleado * 0.01}"],
           ["Adelanto de Salario:", "Bs #{@nomina.adelanto_nomina}"]]
    table(deducciones2) do
      self.column_widths = [150, 390]
    end

    total = [["Totales"]]
    table(total ,:cell_style => { :size => 18, :align => :center}) do
      self.column_widths = [540]
      self.row_colors = ['DDDDDD']
      row(0).font_style = :bold
    end

    total2 = [["Total Asignaciones:", "Bs #{@nomina.salario_nomina + @nomina.alimento_cesta}"],
              ["Total Deducciones:", "Bs #{(@nomina.employee.salario_empleado * 0.04) + (@nomina.employee.salario_empleado * 0.005) + (@nomina.employee.salario_empleado * 0.01) + (@nomina.adelanto_nomina)}"],
              ["Total a Cobrar:", "Bs #{(@nomina.salario_nomina + @nomina.alimento_cesta) - ((@nomina.employee.salario_empleado * 0.04) + (@nomina.employee.salario_empleado * 0.005) + (@nomina.employee.salario_empleado * 0.01) + (@nomina.adelanto_nomina))}"]]
    table(total2) do
      self.column_widths = [150, 390]
    end

  end

  def firma
    bounding_box([340, cursor], width: 200, height: 80) do
      move_down 20
      text "#{@nomina.employee.primer_nombre.upcase} #{@nomina.employee.primer_apellido.upcase}", style: :bold, align: :center
      text "C.I: #{@nomina.employee.numero_cedula}", style: :bold, align: :center
    end
          line [360, 100], [520, 100]
      stroke
  end
