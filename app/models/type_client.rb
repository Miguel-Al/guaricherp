class TypeClient < ApplicationRecord
  has_many :clients, dependent: :restrict_with_exception
end
