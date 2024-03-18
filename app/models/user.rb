class User < ApplicationRecord
  has_many :links, dependent: :destroy

  validates :email, uniqueness: true

  devise :database_authenticatable, :registerable, :validatable
end
