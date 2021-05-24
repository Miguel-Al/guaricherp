class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.string :numero_venta
      t.decimal :total_venta
      t.integer :user_id
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
