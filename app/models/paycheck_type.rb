class PaycheckType < ApplicationRecord
  has_many :paychecks, dependent: :restrict_with_error

  validates :tipo_nomina_nombre, uniqueness: { message: "Ya esta registrado" }  
  validates :tipo_nomina_nombre, presence: { message: "No puede estar vacio" }

end
