class AddPaymentsToStuff < ActiveRecord::Migration[6.1]
  def change
    add_reference :sales, :type_payment, foreign_key: true
    add_reference :purchases, :type_payment, foreign_key: true
  end
end
