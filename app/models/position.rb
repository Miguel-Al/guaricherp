class Position < ApplicationRecord
  has_many :employees, dependent: :restrict_with_error

  validates :nombre_cargo, presence: { message: "No puede estar Vacio" }, format: { with: /\A[a-zA-Z]+\z/, message: "Solo se permiten Letras" }
end
