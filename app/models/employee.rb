class Employee < ApplicationRecord
  belongs_to :position
  has_many :paychecks, dependent: :restrict_with_error
  has_many :phoneployees, dependent: :destroy
  accepts_nested_attributes_for :phoneployees, allow_destroy: :true, reject_if: proc { |att| att['numero_empleado'].blank? }

  validates :salario_empleado, numericality: {greater_than: 0, message: "No puede ser menor a cero"}
  
  validates :numero_cedula, uniqueness: { message: "Ya esta registrado" }
  validates :phoneployees, :numero_cedula, :fecha_ingreso, :direccion_empleado, :salario_empleado, presence: { message: "No puede estar vacio" }
  validates :primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, presence: { message: "No puede estar vacio" }, format: { with: /\A[a-zA-Z]+\z/, message: "Solo se permiten letras" }
  validates_format_of :correo_empleado, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "No es un formato valido", allow_blank: true
  
  def nombre_apellido
    "#{primer_nombre} #{primer_apellido}"
  end

  def nombre_completo
    "#{primer_nombre} #{segundo_nombre} #{primer_apellido} #{segundo_apellido}"
  end

  def salario_diario
    (salario_empleado / 30).round(2)
  end

  def self.buscador(termino)
    Employee.where("primer_nombre LIKE ?", "%#{termino}%")
  end
    
end
