# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

#Administrador
admin = Usuario.new(nombre: "Pablo", apellido: "Gutierrez", email: "admin@gmail.com", password: "qwerty", password_confirmation: "qwerty")
admin.add_role :admin
admin.save!

#Sucursal
suc = Sucursal.new(nombre: "Zucolillo", direccion: "calle 4", telefono: 221345980)
(1..7).map{|x| suc.dias << Dia.new(dia: x, inicio: 7, fin: 18)}
suc.save!

#Cliente
cliente = Cliente.new(nombre: "Belen", apellido: "Suarez", email: "cliente@gmail.com", password: "qwerty", password_confirmation: "qwerty")
cliente.save!
