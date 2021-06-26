class PaycheckType < ApplicationRecord
  has_many :paychecks, dependent: :restrict_with_error

end
