class CreatePhonesuppliers < ActiveRecord::Migration[6.1]
  def change
    create_table :phonesuppliers do |t|
      t.references :supplier, foreign_key: true
      t.string :numero_proveedor

      t.timestamps
    end
  end
end
