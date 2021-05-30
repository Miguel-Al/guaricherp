class CreateTypePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :type_payments do |t|
      t.string :nombre_tipo_pago

      t.timestamps
    end
  end
end
