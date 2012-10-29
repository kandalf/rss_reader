Given /^I am a registered user$/ do
  #current_user = Summoner.summon :user
  #pending "Do nothing relevant here until auth is implemented"
end

When /^I subscribe to "(.*?)" feed$/ do |feed_url|
  post '/subscriptions', :url => feed_url
  response.should be_ok
  response.format.should equals "json"
end
