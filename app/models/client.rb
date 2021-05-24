class Client < ApplicationRecord
  belongs_to :type_client
  has_many :sales

  def self.buscador(termino)
    Client.where("nombre_cliente LIKE ?", "%#{termino}%")
  end

end
