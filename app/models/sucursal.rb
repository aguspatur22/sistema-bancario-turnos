class Sucursal < ApplicationRecord

    # Relaciones
    has_many :turnos, dependent: :destroy
    has_many :dias, dependent: :destroy
    has_many :usuarios, dependent: :destroy

    validates :nombre, :direccion, :telefono, :dias, presence: true
    validates :nombre, uniqueness: true
    validates :nombre, :direccion, length: { maximum: 50 }
    validates :telefono, numericality: { only_integer: true }
end
