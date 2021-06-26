class Location < ApplicationRecord
  has_many :product, dependent: :restrict_with_error

  validates :nombre_lugar, uniqueness: { message: "Ya esta registrado" }
  validates :nombre_lugar, presence: { message: "No puede estar vacio" }
  
end
