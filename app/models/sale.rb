class Sale < ApplicationRecord
  has_many :sale_details, dependent: :destroy
  belongs_to :client, optional: true
  belongs_to :type_payment, optional: true
  belongs_to :user

  default_scope {order(created_at: :desc)}
end
