class Click < ApplicationRecord
  belongs_to :link

  validates :device_ip, :system, :browser, :language, :platform, presence: true
end
