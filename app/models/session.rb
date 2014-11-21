class Session < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :remember_token, presence: true

  def self.get_by_remember_token(remember_token)
    Session.find_by_remember_token(remember_token)
  end

end
