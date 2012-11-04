class Subscription < ActiveRecord::Base
  attr_accessible :title, :url, :user_id

  validates :url, :title, :presence => true

  before_validation :fetch_feed, :if => Proc.new{ |s| s.new_record? }
  after_save :fetch_articles

  has_many :articles

  def fetch_articles
    new_articles = []
    feed.items.each do |item|
      unless articles.map(&:title).include? item.title
        new_articles << articles.create(:link => item.urls.first,
                        :title => item.title,
                        :description => item.description,
                        :pub_date => item.date_published)
      end
    end
    new_articles
  end

  protected
  def fetch_feed
    if new_record? && title.nil?
      @feed = FeedNormalizer::FeedNormalizer.parse(self.url)
      self.title = @feed.title
    end
  end

  def feed
    @feed ||= Proc.new{
      FeedNormalizer::FeedNormalizer.parse(self.url)
    }.call
  end
end
