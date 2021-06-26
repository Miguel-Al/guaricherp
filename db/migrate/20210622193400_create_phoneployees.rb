class CreatePhoneployees < ActiveRecord::Migration[6.1]
  def change
    create_table :phoneployees do |t|
      t.references :employee, foreign_key: true
      t.string :numero_empleado

      t.timestamps
    end
  end
end
