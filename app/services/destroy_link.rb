class DestroyLink
  Result = Struct.new(:success?, :link, keyword_init: true)

  def initialize(link)
    @link = link
  end

  def perform
    link.destroy!
    Result.new({ success?: true })
  end

  attr_accessor :link
end
