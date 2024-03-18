# frozen_string_literal: true

# Service class to create a new link and return a result to the link controller
class CreateLink
  include Base62

  Result = Struct.new(:success?, :link, :errors, keyword_init: true)

  def initialize(link_params, user_id)
    @link_params = link_params
    @user_id = user_id
  end

  def perform
    short_link = Link.create!(**link_params, short_url: generate_short_url, user_id:)
    Result.new({ success?: true, link: short_link })
  rescue ActiveRecord::RecordInvalid => e
    Result.new({ success?: false, errors: e.record.errors.full_messages })
  end

  private

  def generate_short_url
    return unless link_params[:original_url].present?

    url = link_params[:original_url] + user_id.to_s
    hash = Digest::SHA256.hexdigest url
    encode = Base62.encode(hash.to_i(16))
    encode.chars.sample(8).join
  end

  attr_accessor :link_params, :user_id
end
