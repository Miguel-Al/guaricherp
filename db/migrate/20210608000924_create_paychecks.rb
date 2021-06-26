class CreatePaychecks < ActiveRecord::Migration[6.1]
  def change
    create_table :paychecks do |t|
      t.references :user, foreign_key: true
      t.references :employee, foreign_key: true
      t.references :paycheck_type, foreign_key: true
      t.decimal :salario_nomina
      t.date :inicio_nomina
      t.date :fin_nomina

      t.timestamps
    end
  end
end
