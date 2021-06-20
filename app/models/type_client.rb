class TypeClient < ApplicationRecord
  has_many :clients, dependent: :restrict_with_error

  validates :nombre_tipo_cliente, presence: { message: "No puede estar vacio" }
end
