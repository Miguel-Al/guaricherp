class Position < ApplicationRecord
  has_many :employees, dependent: :restrict_with_error
end
