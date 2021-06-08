class CreatePaycheckTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :paycheck_types do |t|
      t.string :tipo_nomina_nombre

      t.timestamps
    end
  end
end
