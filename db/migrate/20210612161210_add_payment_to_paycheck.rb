class AddPaymentToPaycheck < ActiveRecord::Migration[6.1]
  def change
    add_reference :paychecks, :type_payment, foreign_key: true
  end
end
