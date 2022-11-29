class Dia < ApplicationRecord
    #Relaciones
    belongs_to :sucursal

    validates :dia, :inicio,:fin, :sucursal, presence: true
    
end
