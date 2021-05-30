class Purchase < ApplicationRecord
  belongs_to :supplier, optional: true
  belongs_to :user
  has_many :purchase_details, dependent: :destroy

default_scope {order(created_at: :desc)}
end
