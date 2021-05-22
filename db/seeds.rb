# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create(nombre_rol: "admin")
Role.create(nombre_rol: "gerente")
Role.create(nombre_rol: "rrhh")
Role.create(nombre_rol: "vendedor")
Role.create(nombre_rol: "almacenista")
User.create(email: "admin@admin", username: "administrador", password: "000000", password_confirmation: "000000", role_id: "1")
User.create(email: "notadmin@notadmin", username: "noadministrador", password: "111111", password_confirmation: "111111", role_id: "2")
