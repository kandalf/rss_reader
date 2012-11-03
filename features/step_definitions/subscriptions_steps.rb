Given /^I am a registered user$/ do
  #current_user = Summoner.summon :user
  #pending "Do nothing relevant here until auth is implemented"
end

When /^I subscribe to "(.*?)" feed$/ do |feed_url|
  response = page.driver.post '/subscriptions', :subscription => {:url => feed_url}
  response.should be_ok
  subscription_attrs = JSON.parse(response.body)
  subscription_attrs["url"].should == feed_url
  subscription_attrs["title"].should_not be_nil
end

Then /^I should have "(.*?)" in my subscriptions list$/ do |domain_name|
  urls = Subscription.all.map(&:url).join(" ")
  urls.should include domain_name
end

Given /^I have a subscription to "(.*?)"$/ do |domain_name|
  feed_url = "http://#{domain_name}/rss.xml"
  subscription = Subscription.create({:url => feed_url, :title => domain_name.capitalize})
end

Given /^I have a subscription to$/ do |table|
  table.hashes.each do |attrs|
    attrs['url'] = "http://#{attrs['domain']}/rss.xml"
    attrs['title'] = attrs['domain'].capitalize
    attrs.delete('domain')
    Subscription.create(attrs)
  end
end

When /^I unsubscribe from "(.*?)"$/ do |domain_name|
  feed_url = "http://#{domain_name}/rss.xml"
  subscription = Subscription.find_by_url(feed_url)

  response = page.driver.delete "/subscriptions/#{subscription.id}"
  response.should be_ok
end

Then /^I should not have a subscription to "(.*?)"$/ do |domain_name|
  urls = Subscription.all.map(&:url).join(" ")
  urls.should_not include domain_name
end

When /^I go to my subscriptions index$/ do
  response = page.driver.get '/subscriptions'
  response.should be_ok
end

Then /^I should see "(.*?)"$/ do |text|
  page.body.downcase.should include text.downcase
end
