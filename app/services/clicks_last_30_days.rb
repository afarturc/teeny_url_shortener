class ClicksLast30Days
  Result = Struct.new(:success?, :clicks, keyword_init: true)

  def initialize(link)
    @link = link
  end

  def perform
    clicks = @link.clicks.group_by_day(:created_at, last: 30, expand_range: true)

    if clicks.empty?
      Result.new({ success?: false })
    else
      Result.new({ success?: true, clicks: clicks.count })
    end
  end
end
