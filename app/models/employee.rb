class Employee < ApplicationRecord
  belongs_to :position
  #implementar esto para validar los correos en creacion
   validates_format_of :correo_empleado, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
end
