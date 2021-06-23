class CreatePurchases < ActiveRecord::Migration[6.1]
  def change
    create_table :purchases do |t|
      t.integer :numero_compra
      t.decimal :total_compra
      t.integer :user_id
      t.references :supplier, foreign_key: true

      t.timestamps
    end
  end
end
