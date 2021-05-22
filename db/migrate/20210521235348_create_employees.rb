class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :numero_cedula
      t.string :primer_nombre
      t.string :segundo_nombre
      t.string :primer_apellido
      t.string :segundo_apellido
      t.date :fecha_ingreso
      t.string :correo_empleado

      t.timestamps
    end
  end
end
