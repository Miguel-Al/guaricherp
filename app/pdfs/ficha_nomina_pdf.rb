require 'prawn/table'
class FichaNominaPdf < Prawn::Document
  def initialize(nomina)
    super()
    @nomina = nomina
    titulo
    listado
    firma
  end
end

  def titulo
    text "Nomina de pago del empleado #{@nomina.employee.nombre_apellido}", size: 20, style: :bold
    text "Periodo #{@nomina.inicio_nomina} - #{@nomina.fin_nomina}"
  end

  def listado
    move_down 20
    info = [["Empleado:", "Cedula:", "Cargo" ],
            ["#{@nomina.employee.primer_nombre} #{@nomina.employee.primer_apellido}", @nomina.employee.numero_cedula, @nomina.employee.position.nombre_cargo ]]
    table(info) do
      self.column_widths = [200, 200, 140]
      self.row_colors = ['DDDDDD', 'FFFFFF']
    end

    info2 = [["Salario:", "Forma de pago:", "Tipo de Nomina:"],
             ["Bs #{@nomina.employee.salario_empleado}", @nomina.type_payment.nombre_tipo_pago, @nomina.paycheck_type.tipo_nomina_nombre]]
    table(info2) do
      self.column_widths = [275, 125, 140]
      self.row_colors = ['DDDDDD', 'FFFFFF']
    end

    asignaciones = [["Asignaciones"]]
    table(asignaciones ,:cell_style => { :size => 18, :align => :center}) do
      self.column_widths = [540]
      self.row_colors = ['DDDDDD']
    end

    asignaciones2 = [["Total dias trabajados:", "#{@nomina.dias_nomina} dias", "Bs #{(@nomina.employee.salario_empleado / 30).round(2)} por dia", "Bs #{@nomina.salario_nomina}"]]
    table(asignaciones2) do
      self.column_widths = [150, 100, 100, 190]
    end

    asignaciones3 = [["Cesta Ticket", "Bs valor"]]
    table(asignaciones3) do
      self.column_widths = [150, 390]
    end

    deducciones = [["Deducciones"]]
    table(deducciones ,:cell_style => { :size => 18, :align => :center}) do
      self.column_widths = [540]
      self.row_colors = ['DDDDDD']
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
    end

    total2 = [["Total Asignaciones:", "Bs #{@nomina.salario_nomina}"],
              ["Total Deducciones:", "Bs #{(@nomina.employee.salario_empleado * 0.04) + (@nomina.employee.salario_empleado * 0.005) + (@nomina.employee.salario_empleado * 0.01)}"],
              ["Total a cobrar:", "Bs #{(@nomina.salario_nomina) - ((@nomina.employee.salario_empleado * 0.04) + (@nomina.employee.salario_empleado * 0.005) + (@nomina.employee.salario_empleado * 0.01))}"]]
    table(total2) do
      self.column_widths = [150, 390]
    end

  end

  def firma
    line [350, 150], [500, 150]
    stroke
    move_down 130
    draw_text "#{@nomina.employee.primer_nombre} #{@nomina.employee.primer_apellido}", at: [375, 130]
    draw_text "#{@nomina.employee.numero_cedula}", at: [375, 110]
  end
