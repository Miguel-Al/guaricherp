class Position < ApplicationRecord
  has_many :employees, dependent: :restrict_with_error

  validates :nombre_cargo, presence: { message: "No puede estar vacio" }
end
