class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookmarks, dependent: :destroy

  validates :first_name, presence: :true
  validates :last_name, presence: :true
  validates :age, presence: :true, numericality: { only_integer: true }
  validates :availability, presence: :true, numericality: { only_integer: true }
end
