class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :rif_empresa
      t.string :nombre_empresa
      t.string :direccion_empresa
      t.integer :telefono_empresa
      
      t.timestamps
    end
  end
end
