class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  has_many :recipes, dependent: :destroy
  has_many :foods
  has_many :inventories
end
