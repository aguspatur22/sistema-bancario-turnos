class Usuario < ApplicationRecord
  rolify

  # Relaciones
  belongs_to :sucursal, optional: true


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :validatable, :recoverable

  validates :email, :password, :nombre, :apellido, presence: true
  validates :email, uniqueness: true
  validates :email, :nombre, :apellido, length: {maximum: 50}
  validates :password, confirmation: true, length: { in: 6..20 }
  validates :password_confirmation, presence:true
  end