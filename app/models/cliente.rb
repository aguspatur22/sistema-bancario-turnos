class Cliente < ApplicationRecord

  validates :email, :password, presence: true
  validates :email, uniqueness: true
  validates :email, length: {maximum: 50}
  validates :password, confirmation: true, length: { in: 6..20 }
  validates :password_confirmation, presence:true


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :recoverable

  # Relaciones
  has_many :turnos, dependent: :destroy
end
