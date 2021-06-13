class Category < ApplicationRecord
  has_many :products, dependent: :restrict_with_error

  validates :nombre_categoria, presence: { message: "No puede estar vacio" }, format: { with: /\A[a-zA-Z]+\z/, message: "Solo se permiten letras" }
  default_scope {order(nombre_categoria: :asc)}
  
end
