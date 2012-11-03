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

Then /^I should have "(.*?)" in my subscriptions list$/ do |feed_domain_name|
  urls = Subscription.all.map(&:url).join(" ")
  urls.should include feed_domain_name
end
