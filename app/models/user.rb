class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable

  has_many :links, dependent: :destroy

  validates :email, uniqueness: true
end
