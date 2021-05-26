class Supplier < ApplicationRecord
  has_many :purchases

  def self.buscador(termino)
    Supplier.where("nombre_proveedor LIKE ?", "%#{termino}%")
  end
end
