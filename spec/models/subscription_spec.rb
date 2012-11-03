require 'spec_helper'

describe Subscription do
  it "should not allow empty url" do
    subscription = Subscription.new({:url => nil, :title => "Example"})
    subscription.should_not be_valid
    subscription.errors.messages.keys.should include :url
  end

  it "should not allow empty title" do
    subscription = Subscription.create({:title => "Example", :url => "http://example.com"})

    subscription.title = nil
    subscription.should_not be_valid
    subscription.errors.messages.keys.should include :title
  end

  it "should take title from URL if not provided" do
    #mock the external data
    feed = mock(FeedNormalizer::Feed)
    feed.stub!(:title).and_return("XKCD")
    FeedNormalizer::FeedNormalizer.stub!(:parse).and_return(feed)
    
    subscription = Subscription.create({:url => "http://xkcd.com/rss.xml"})
    subscription.title.should == feed.title
  end

  it "should not take title from URL if provided" do
    #Make sure no call is made to the feed URL
    FeedNormalizer::FeedNormalizer.should_not_receive(:parse)

    subscription = Subscription.new({:url => "http://example.com", :title=> "Example"})

    subscription.title.should == "Example"
  end
end
