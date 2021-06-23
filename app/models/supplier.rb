class Supplier < ApplicationRecord
  has_many :purchases, dependent: :restrict_with_error
  has_many :phonesuppliers, dependent: :destroy
  accepts_nested_attributes_for :phonesuppliers, allow_destroy: :true, reject_if: proc { |att| att['numero_proveedor'].blank? }

  validates :rif_proveedor, :direccion_proveedor, :nombre_proveedor, uniqueness: { message: "Ya esta registrado" }
  
  validates :phonesuppliers, :rif_proveedor, :direccion_proveedor, :nombre_proveedor, presence: { message: "No puede estar vacio" }
  validates_format_of :correo_proveedor, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "No es un formato valido", allow_blank: true
  default_scope {order(rif_proveedor: :asc)}

  def self.buscador(termino)
    Supplier.where("nombre_proveedor LIKE ?", "%#{termino}%")
  end
end
