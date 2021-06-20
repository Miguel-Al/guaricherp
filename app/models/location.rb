class Location < ApplicationRecord
  has_many :product, dependent: :restrict_with_error
end
