class Turno < ApplicationRecord
    # Relaciones
    belongs_to :cliente
    belongs_to :sucursal

    validates :fecha, :motivo, :cliente, :sucursal, presence: true
end
