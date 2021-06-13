class AddDirectionToAll < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :direccion_cliente, :string
    add_column :employees, :direccion_empleado, :string
    add_column :suppliers, :direccion_proveedor, :string
  end
end
