class Paycheck < ApplicationRecord
  belongs_to :user
  belongs_to :employee, optional: true
  belongs_to :paycheck_type, optional: true

end
