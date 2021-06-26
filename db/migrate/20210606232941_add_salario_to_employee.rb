class AddSalarioToEmployee < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :salario_empleado, :decimal
  end
end
