class CreateUnits < ActiveRecord::Migration[6.1]
  def change
    create_table :units do |t|
      t.string :nombre_unidad
      t.string :simbolo_unidad

      t.timestamps
    end
  end
end
