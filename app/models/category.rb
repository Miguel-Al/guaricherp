class Category < ApplicationRecord
  has_many :products, dependent: :restrict_with_error
  has_paper_trail
  
  before_validation { |category| category.nombre_categoria = category.nombre_categoria.downcase }

  validates :nombre_categoria, uniqueness: { message: "Ya esta registrado" }
  validates :nombre_categoria, presence: { message: "No puede estar vacio" }, format: { with: /\A[a-zA-Z]+\z/, message: "Solo se permiten letras" }

  default_scope {order(nombre_categoria: :asc)} 
end
