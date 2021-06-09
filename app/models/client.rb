class Client < ApplicationRecord
  belongs_to :type_client
  has_many :sales
  has_many :phoneclients, dependent: :destroy
  accepts_nested_attributes_for :phoneclients, allow_destroy: :true, reject_if: proc { |att| att['numero_cliente'].blank? }

  def self.buscador(termino)
    Client.where("nombre_cliente LIKE ?", "%#{termino}%")
  end

end
