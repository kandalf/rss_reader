class Subscription < ActiveRecord::Base
  attr_accessible :title, :url, :user_id

  validates :url, :title, :presence => true

  before_validation :fetch_feed, :if => Proc.new{ |s| s.new_record? }

  protected
  def fetch_feed
    if new_record? && title.nil?
      @feed = FeedNormalizer::FeedNormalizer.parse(attributes[:url])
      self.title = @feed.title
    end
  end
end
