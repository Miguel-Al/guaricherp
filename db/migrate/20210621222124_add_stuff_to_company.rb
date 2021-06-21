class AddStuffToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :rif_empresa, :string
    add_column :companies, :nombre_empresa, :string
    add_column :companies, :numero_control, :string
    add_column :companies, :direccion_empresa, :string
    add_column :companies, :telefono_empresa, :string
  end
end
