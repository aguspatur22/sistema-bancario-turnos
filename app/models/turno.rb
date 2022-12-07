class Turno < ApplicationRecord
    attr_accessor :dia, :hora, :minutos

    # Relaciones
    belongs_to :cliente
    belongs_to :sucursal

    validates :motivo, :cliente, :sucursal, :estado, presence: true

end
