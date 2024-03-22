# frozen_string_literal: true

class CreateClick
  Result = Struct.new(:success?, :click, :errors, keyword_init: true)

  def initialize(link_id, click_params)
    @link_id = link_id
    @click_params = click_params
  end

  def perform
    click = Click.create!(**click_params, link_id:)
    Result.new({ success?: true, click: })
  rescue ActiveRecord::RecordInvalid => e
    Result.new({ success?: false, errors: e.record.errors.full_messages })
  end

  private

  attr_reader :link_id, :click_params
end
