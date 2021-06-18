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
    text "Nomina de pago del empleado #{@nomina.employee.primer_nombre} #{@nomina.employee.primer_apellido}", size: 10, style: :bold
    text "Periodo #{@nomina.inicio_nomina} - #{@nomina.fin_nomina}"
  end

  def listado
    move_down 10
    table [["Empleado:", "Cedula:", "Cargo" ],
           ["#{@nomina.employee.primer_nombre} #{@nomina.employee.primer_apellido}", @nomina.employee.numero_cedula, @nomina.employee.position.nombre_cargo ]]
    table [["Salario:", "Forma de pago:", "Tipo de Nomina:"],
           ["Bs #{@nomina.employee.salario_empleado}", @nomina.type_payment.nombre_tipo_pago, @nomina.paycheck_type.tipo_nomina_nombre]]
    table [["Asignaciones:"],
           ["Total dias trabajados", "#{@nomina.dias_nomina} dias", "Bs #{(@nomina.employee.salario_empleado / 30).round(2)} por dia", "Bs #{@nomina.salario_nomina}"],
           ["Cesta Ticket", "valor"]]
    table [["Deducciones:"],
           ["S.S.O 4%", "Bs #{@nomina.employee.salario_empleado * 0.04}"],
           ["Regimen prestacional de empleo 0,5%", "Bs #{@nomina.employee.salario_empleado * 0.005}"],
           ["FAOV 1%", "Bs #{@nomina.employee.salario_empleado * 0.01}"],
           ["Adelanto de Salario:", "Bs #{@nomina.adelanto_nomina}"]]
    table [["Total Asignaciones:", "Bs #{@nomina.salario_nomina}"],
           ["Total Deducciones:", "Bs #{(@nomina.employee.salario_empleado * 0.04) + (@nomina.employee.salario_empleado * 0.005) + (@nomina.employee.salario_empleado * 0.01)}"]]
    table [["Total a cobrar:", "Bs #{(@nomina.salario_nomina) - ((@nomina.employee.salario_empleado * 0.04) + (@nomina.employee.salario_empleado * 0.005) + (@nomina.employee.salario_empleado * 0.01))}"]]
  end

  def firma
    line [350, 200], [500, 200]
    stroke
    move_down 130
    draw_text "#{@nomina.employee.primer_nombre} #{@nomina.employee.primer_apellido}", at: [375, 180]
    draw_text "#{@nomina.employee.numero_cedula}", at: [375, 160]
  end
