class Client < ApplicationRecord
  belongs_to :type_client
  has_many :sales, dependent: :restrict_with_error
  has_many :phoneclients, dependent: :destroy
  accepts_nested_attributes_for :phoneclients, allow_destroy: :true, reject_if: proc { |att| att['numero_cliente'].blank? }

  validates :rif_cliente, :direccion_cliente, :nombre_cliente, uniqueness: { message: "Ya esta registrado" }
  
  validates :phoneclients, :rif_cliente, :direccion_cliente, :nombre_cliente, presence: { message: "No puede estar vacio" }
  validates_format_of :correo_cliente, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "No es un formato valido", allow_blank: true
  default_scope {order(rif_cliente: :asc)}
  
  def self.buscador(termino)
    Client.where("nombre_cliente LIKE ?", "%#{termino}%")
  end

end
