# frozen_string_literal: true

class CreateClick
  Result = Struct.new(:success?, :click, :errors, keyword_init: true)

  def initialize(link, click_params)
    @link = link
    @click_params = click_params
  end

  def perform
    click = link.clicks.create!(click_params)
    Result.new({ success?: true, click: })
  rescue ActiveRecord::RecordInvalid => e
    Result.new({ success?: false, errors: e.record.errors.full_messages })
  end

  private

  attr_accessor :link, :click_params
end
