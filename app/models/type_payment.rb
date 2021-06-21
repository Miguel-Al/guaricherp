class TypePayment < ApplicationRecord
  has_many :paychecks, dependent: :restrict_with_error
  has_many :sales, dependent: :restrict_with_error
  has_many :purchases, dependent: :restrict_with_error

  validates :nombre_tipo_pago, presence: { message: "No puede estar vacio" }
end
