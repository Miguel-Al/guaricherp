# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
roles = [ "admin", "gerente", "rrhh", "vendedor", "almacenista"]
roles.each do |nombre|
  Role.create(nombre_rol: nombre)
end

pagos = [ "efectivo", "cheque", "otro"]
pagos.each do |nombre|
  TypePayment.create(nombre_tipo_pago: nombre)
end

categorias = [ "maderas", "clavos", "chapas", "mdf", "mdp"]
categorias.each do |nombre|
  Category.create(nombre_categoria: nombre)
end

ubicaciones = [ "b-31", "a-22", "z-01"]
ubicaciones.each do |nombre|
  Location.create(nombre_lugar: nombre)
end

clientes = [ "juridico", "natural"]
clientes.each do |nombre|
  TypeClient.create(nombre_tipo_cliente: nombre)
end

cargos = [ "vendedor", "chofer", "conserje", "gerente", "almacenista"]
cargos.each do |nombre|
  Position.create(nombre_cargo: nombre)
end

nominas = [ "quincenal", "semanal"]
nominas.each do |nombre|
  PaycheckType.create(tipo_nomina_nombre: nombre)
end

Unit.create(nombre_unidad: "unidad", simbolo_unidad: "unt")
Unit.create(nombre_unidad: "metro", simbolo_unidad: "mts")
Unit.create(nombre_unidad: "kilogramo", simbolo_unidad: "kg")

User.create(email: "admin@admin", username: "administrador", password: "000000", password_confirmation: "000000", role_id: "1")
User.create(email: "notadmin@notadmin", username: "noadministrador", password: "111111", password_confirmation: "111111", role_id: "2")
