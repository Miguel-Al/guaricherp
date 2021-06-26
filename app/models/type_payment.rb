class TypePayment < ApplicationRecord
  has_many :paychecks, dependent: :restrict_with_error
  has_many :sales, dependent: :restrict_with_error
  has_many :purchases, dependent: :restrict_with_error

  
  before_validation { |pago| pago.nombre_tipo_pago = pago.nombre_tipo_pago.downcase }

  validates :nombre_tipo_pago, uniqueness: { message: "Ya esta registrado" }
  validates :nombre_tipo_pago, presence: { message: "No puede estar vacio" }, format: { with: /\A[a-zA-Z]+\z/, message: "Solo se permiten letras" }

end
