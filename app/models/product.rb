class Product < ApplicationRecord
  belongs_to :category
  belongs_to :unit
  belongs_to :location
end
