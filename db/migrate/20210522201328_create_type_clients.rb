class CreateTypeClients < ActiveRecord::Migration[6.1]
  def change
    create_table :type_clients do |t|
      t.string :nombre_tipo_cliente

      t.timestamps
    end
  end
end
