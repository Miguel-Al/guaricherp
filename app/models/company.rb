class Company < ApplicationRecord

  validates :rif_empresa, :nombre_empresa, :numero_control, :direccion_empresa, :telefono_empresa, presence: { message: "No puede estar vacio" }
  
end
