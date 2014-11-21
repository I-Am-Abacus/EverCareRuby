class Follow < ActiveRecord::Base
  belongs_to :cared_for_user, class_name: 'User', foreign_key: :cared_for_user_id, inverse_of: :cared_for_link_following_user
  belongs_to :following_user, class_name: 'User', foreign_key: :following_user_id, inverse_of: :following_link_cared_for_user
  validates :cared_for_user_id, presence: true
  validates :following_user_id, presence: true
end
