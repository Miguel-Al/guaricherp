class CreatePurchaseDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :purchase_details do |t|
      t.integer :cantidad
      t.references :product, foreign_key: true
      t.references :purchase, foreign_key: true

      t.timestamps
    end
  end
end
