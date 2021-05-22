class CreateSuppliers < ActiveRecord::Migration[6.1]
  def change
    create_table :suppliers do |t|
      t.string :rif_proveedor
      t.string :nombre_proveedor
      t.string :correo_proveedor
      t.string :descripcion_proveedor

      t.timestamps
    end
  end
end
