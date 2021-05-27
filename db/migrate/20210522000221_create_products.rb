class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :codigo_producto
      t.string :nombre_producto
      t.integer :existencia_producto
      t.string :descripcion_producto
      t.decimal :precio_producto
      t.integer :min_producto
      t.boolean :condicion_producto
      t.references :category, null: false, foreign_key: true
      t.references :unit, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
