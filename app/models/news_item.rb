class NewsItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :carer_user, class_name: 'User', foreign_key: :carer_user_id, inverse_of: :carer_posted_news_items

end
