# frozen_string_literal: true

class UpdateLink
  Result = Struct.new(:success?, :link, :errors, keyword_init: true)

  def initialize(link, link_params)
    @link = link
    @link_params = link_params
  end

  def perform
    link.update!(link_params)

    Result.new({ success?: true, link: })
  rescue ActiveRecord::RecordInvalid => e
    Result.new({ success?: false, errors: e.record.errors.full_messages })
  end

  private

  attr_accessor :link, :link_params
end
