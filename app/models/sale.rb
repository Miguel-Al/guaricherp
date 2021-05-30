class Sale < ApplicationRecord
  has_many :sale_details, dependent: :destroy
  belongs_to :client, optional: true
  belongs_to :user
  #si borra una venta borro todas los detalles de la misma

  default_scope {order(created_at: :desc)}
end
