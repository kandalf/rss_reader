class Article < ActiveRecord::Base
  attr_accessible :description, :link, :pub_date, :starred, :title

  belongs_to :subscription
end
