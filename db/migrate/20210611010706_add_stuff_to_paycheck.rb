class AddStuffToPaycheck < ActiveRecord::Migration[6.1]
  def change
    add_column :paychecks, :dias_nomina, :integer
    add_column :paychecks, :horas_extra, :integer
    add_column :paychecks, :adelanto_nomina, :decimal
  end
end
