class Unit < ApplicationRecord
  has_many :products, dependent: :restrict_with_error

  validates :nombre_unidad, presence: true
  validates :simbolo_unidad, presence: true
  
end
