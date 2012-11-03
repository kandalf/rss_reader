class Subscription < ActiveRecord::Base
  attr_accessible :name, :url, :user_id

  validates :url, :presence => true
  validates :title, :presence => true
end
