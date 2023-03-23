class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookmarks, dependent: :destroy

  validates :first_name, presence: :true
  validates :last_name, presence: :true
  validates :age, presence: :true, numericality: { only_integer: true }
  validates :availability, numericality: { only_integer: true, greater_than: 0 }

  has_one_attached :photo
end
