# TFI Ruby: Sistema turnos bancarios
## Agustin Paturlanne 

#### Informacion tecnica de la aplicacion
- Version de ruby: *3.1.2*
- Version de rails: *~> 7.0.4*
- Gemas incluidas: 
> sassc-rails
devise
gem rolify
gem cancancan
gem bootstrap ~> 5.2.2

- Base de datos: *sqlite3 ~> 1.4*


#### Pasos para iniciar la aplicacion

1. git clone git@github.com:aguspatur22/sistema-bancario-turnos.git (SSH)
2. Configurar la base de datos y aplicar seeds: 
	2.1 rails db:drop
	2.2 rails db:create
	2.3 rails db:migrate
	2.4 rails db:seed
3. rails s (levantar el proyecto)
4. Url: http://127.0.0.1:3000


#### Reglas de negocio

##### Turnos
* Solo se puede solicitar un turno para una misma sucursal en un mismo dia
* Los turnos ya atendidos NO se pueden eliminar, solo los pendientes
* Turnos pendientes solo se puede modificar el motivo de la solicitud, en caso de querer otro dia o sucursal se debera cancelar el turno actual y solicitar uno nuevo

##### Modelos cliente y usuario
* Se separaron en dos modelos distintos a los usuarios clientes de los usuarios administradores y personal bancario. Se hace esta distincion por el hecho de que los usuarios clientes se pueden registrar solos, en cambio los admin y personal solo pueden ser creados por un administrador. No solo eso, sino que el ingreso a la aplicacion es desde portal publico (clientes) y desde portal privado (admin y personal).

##### Roles y permisos
* Cada rol tiene especificados sus permisos en el modelo ability.rb
* Un administrador es el unico que puede cambiar los roles de los usuarios admin y personal. Caso especifico en que se cambia su rol, se le cierra su sesion y debe loguearse de nuevo para ver reflejados los cambios

##### Sucursales
* Usuarios personal solo existen mientras exista su sucursal, si eliminan a esta entonces se eliminan los usuarios personal asociados a ella
* En una consulta practica se pidio que se incluyan los dias sabados y domingos a los horarios de las sucursales como disponibles para atencion
