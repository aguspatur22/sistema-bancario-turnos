class Turno < ApplicationRecord
    # Relaciones
    belongs_to :cliente
    belongs_to :sucursal

    validates :dia, :hora, :motivo, :cliente, :sucursal, :estado, presence: true
end
