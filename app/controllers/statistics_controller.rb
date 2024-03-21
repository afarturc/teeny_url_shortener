class StatisticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link

  def clicks_last_30_days
    result = ClicksLast30Days.new(@link).perform

    if result.success?
      render json: result.clicks
    else
      render json: nil
    end
  end

  def clicks_most_popular_hours
    result = ClicksMostPopularHours.new(@link).perform

    if result.success?
      render json: result.clicks
    else
      render json: nil
    end
  end

  def clicks_most_popular_days_of_week
    result = ClicksMostPopularDaysOfWeek.new(@link).perform

    if result.success?
      render json: result.clicks
    else
      render json: nil
    end
  end

  def clicks_most_popular_languages
    result = ClicksMostPopularLanguages.new(@link).perform

    if result.success?
      render json: result.clicks
    else
      render json: nil
    end
  end

  private

  def set_link
    @link = Link.find(params[:link_id])
  end
end
