class CreatePhoneclients < ActiveRecord::Migration[6.1]
  def change
    create_table :phoneclients do |t|
      t.references :client, foreign_key: true
      t.string :numero_cliente

      t.timestamps
    end
  end
end
