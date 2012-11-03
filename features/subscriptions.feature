Feature: RSS Subscriptions
  In order to read digests I'm interested in
  As a registered user
  I want to have a list of subscriptions

  Scenario: Subscribe to a new feed
    Given I am a registered user
     When I subscribe to "http://xkcd.com/rss.xml" feed
     Then I should have "xkcd.com" in my subscriptions list

  Scenario: Unsubscribe from a feed
    Given I am a registered user
      And I have a subscription to "xkcd.com"
     When I unsubscribe from "xkcd.com"
     Then I should not have a subscription to "xkcd.com"

  Scenario: Listing subscriptions
    Given I am a registered user
      And I have a subscription to
        | domain                |
        | xkcd.com              |
        | threefunkymonkeys.com |
     When I go to my subscriptions index
     Then I should see "xkcd.com"
      And I should see "threefunkymonkeys.com"
        
