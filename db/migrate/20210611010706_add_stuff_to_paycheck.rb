class AddStuffToPaycheck < ActiveRecord::Migration[6.1]
  def change
    add_column :paychecks, :dias_nomina, :integer
    add_column :paychecks, :alimento_cesta, :decimal
    add_column :paychecks, :adelanto_nomina, :decimal
    add_column :paychecks, :salario_empleado, :decimal
  end
end
