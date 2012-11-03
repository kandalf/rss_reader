class Subscription < ActiveRecord::Base
  attr_accessible :title, :url, :user_id

  validates :url, :title, :presence => true

  before_validation :fetch_feed, :if => Proc.new{ |s| s.new_record? }
  after_save :save_articles

  has_many :articles

  protected
  def fetch_feed
    if new_record? && title.nil?
      @feed = FeedNormalizer::FeedNormalizer.parse(self.url)
      self.title = @feed.title
    end
  end

  def save_articles
    if @feed
      @feed.items.each do |item|
        articles.create(:link => item.urls.first,
                        :title => item.title,
                        :description => item.description,
                        :pub_date => item.date_published)
      end
    end
  end
end
