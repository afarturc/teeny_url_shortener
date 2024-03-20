class ChartsController < ApplicationController
  before_action :set_link

  def clicks_day
    @data = @link.clicks.group_by_day(:created_at, range: 2.weeks.ago..Time.now, expand_range: true).count
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('chart', partial: 'clicks_day_chart') }
    end
  end

  def clicks_hour
    @data = @link.clicks.group_by_hour_of_day(:created_at, expand_range: true).count
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('chart', partial: 'clicks_hour_chart') }
    end
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end
end
