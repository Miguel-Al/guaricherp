class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :rif_cliente
      t.string :nombre_cliente
      t.string :correo_cliente
      t.string :descripcion_cliente

      t.timestamps
    end
  end
end
