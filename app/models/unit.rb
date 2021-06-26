class Unit < ApplicationRecord
  has_many :products, dependent: :restrict_with_error

  validates :nombre_unidad, :simbolo_unidad, uniqueness: { message: "Ya esta registrado" }
  validates :nombre_unidad, :simbolo_unidad, presence: { message: "No puede estar vacio" }
  
end
