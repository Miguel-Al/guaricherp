class Paycheck < ApplicationRecord
  belongs_to :user
  belongs_to :employee, optional: true
  belongs_to :paycheck_type, optional: true
  belongs_to :type_payment, optional: true

  validates :employee, presence: true, on: :update
  
  def periodo
    "#{inicio_nomina} - #{fin_nomina}"
  end

end
