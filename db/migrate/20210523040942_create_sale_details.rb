class CreateSaleDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :sale_details do |t|
      t.integer :cantidad
      t.references :product, foreign_key: true
      t.references :sale, foreign_key: true

      t.timestamps
    end
  end
end
