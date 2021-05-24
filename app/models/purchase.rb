class Purchase < ApplicationRecord
  belongs_to :supplier, optional: true
  belongs_to :user
end
