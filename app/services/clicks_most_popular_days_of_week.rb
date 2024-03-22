class ClicksMostPopularDaysOfWeek
  Result = Struct.new(:success?, :clicks, keyword_init: true)

  def initialize(link)
    @link = link
  end

  def perform
    clicks = @link.clicks.group_by_day_of_week(:created_at, expand_range: true, format: '%A')

    if clicks.empty?
      Result.new({ success?: false })
    else
      Result.new({ success?: true, clicks: clicks.count })
    end
  end
end
