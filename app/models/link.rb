class Link < ApplicationRecord
  belongs_to :user
  has_many :clicks, dependent: :destroy

  validate :expires_at_cannot_be_in_the_past
  validates :original_url, :short_url, :name, :description, presence: true

  def expired?
    expires_at.present? && expires_at < Date.today
  end

  private

  def expires_at_cannot_be_in_the_past
    return unless expired?

    errors.add(:expires_at, :past_date)
  end
end
