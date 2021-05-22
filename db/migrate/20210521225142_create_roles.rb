class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.string :nombre_rol

      t.timestamps
    end
  end
end
