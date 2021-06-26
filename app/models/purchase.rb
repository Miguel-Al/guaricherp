class Purchase < ApplicationRecord
  belongs_to :supplier, optional: true
  belongs_to :user
  has_many :purchase_details, dependent: :destroy
  belongs_to :type_payment, optional: true

  default_scope {order(created_at: :desc)}
end
