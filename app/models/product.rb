class Product < ApplicationRecord
  belongs_to :category
  belongs_to :unit
  belongs_to :location

  def self.buscador(termino)
    Product.where("nombre_producto LIKE ?", "%#{termino}%")
  end
  
end
