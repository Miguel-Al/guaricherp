class Product < ApplicationRecord
  belongs_to :category
  belongs_to :unit
  belongs_to :location
  has_many :sale_details, dependent: :restrict_with_error
  has_many :purchase_details, dependent: :restrict_with_error

  validates :codigo_producto, uniqueness: { message: "Ya esta registrado" }
  validates :codigo_producto, :nombre_producto, :precio_producto, :existencia_producto, :min_producto, presence: { message: "No puede estar vacio" }

  validates :precio_producto, :existencia_producto, :min_producto, numericality: {greater_than: 0, message: "No puede ser menor a cero"}
  
  def self.buscador(termino)
    Product.where("nombre_producto LIKE ?", "%#{termino}%").or(Product.where("codigo_producto LIKE ?", "%#{termino}%"))
  end

  def self.buscadorcompra(termino)
    Product.where("nombre_producto LIKE ?", "%#{termino}%").or(Product.where("codigo_producto LIKE ?", "%#{termino}%"))
  end

  default_scope {order(codigo_producto: :asc)}
end
