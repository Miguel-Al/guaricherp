class Paycheck < ApplicationRecord
  belongs_to :user
  belongs_to :employee, optional: true
  belongs_to :paycheck_type, optional: true

  def periodo
    "#{inicio_nomina} - #{fin_nomina}"
  end

  def sueldo_dia
    (salario_nomina / 30).round(2)
  end

  def abonacion
    sueldo_dia * dias_nomina
  end

  def total_final
    e = ((salario_nomina * 0.04) + (salario_nomina * 0.005) + (salario_nomina * 0.01))
    if horas_extra > 0
      i = ((1.1 * horas_extra) * (abonacion)).round(2)
    else
      i = abonacion
    end
    if adelanto_nomina > 0
      u = adelanto_nomina
    else
      u = 0
    end
    (i) - (u) - (e)
  end
end
