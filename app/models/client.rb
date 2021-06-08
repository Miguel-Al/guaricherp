class Client < ApplicationRecord
  belongs_to :type_client
  has_many :sales
  has_many :phoneclients
  accepts_nested_attributes_for :phoneclients

  def self.buscador(termino)
    Client.where("nombre_cliente LIKE ?", "%#{termino}%")
  end

end
