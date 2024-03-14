class Click < ApplicationRecord
  validates :device_ip, :system, :browser, :language, :platform, presence: true

  belongs_to :link
end
