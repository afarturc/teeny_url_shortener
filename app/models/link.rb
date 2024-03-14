class Link < ApplicationRecord
  validate :expired_at_cannot_be_in_the_past

  validates :original_url, :short_url, presence: true

  belongs_to :user
  has_many :clicks, dependent: :destroy

  def expired?
    expired_at.present? && expired_at < Date.today
  end

  private

  def expired_at_cannot_be_in_the_past
    return unless expired?

    errors.add(:expired_at, :past_date)
  end
end
