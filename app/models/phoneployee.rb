class Phoneployee < ApplicationRecord
  belongs_to :employee

  validates :numero_empleado, uniqueness: { message: "Ya esta registrado" }
  validates :numero_empleado, presence: { message: "No puede estar vacio" }

end
