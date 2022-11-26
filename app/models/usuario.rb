class Usuario < ApplicationRecord
  rolify

  # Relaciones
  has_one :sucursal


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :validatable

  validates :email, :password, presence: true
  validates :email, uniqueness: true
  validates :email, length: {maximum: 50}
  validates :password, confirmation: true, length: { in: 6..20 }
  validates :password_confirmation, presence:true
  end