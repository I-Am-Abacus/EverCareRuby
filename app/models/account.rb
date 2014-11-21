class Account < ActiveRecord::Base
  belongs_to :user

  has_many :plots, inverse_of: :account, dependent: :destroy

  enum status: { initial: 1, active: 2, suspended: 3 }

  validates :user, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :public, inclusion: { in: [true, false] }
  validates :status, presence: true

  def display_name
    if name.blank?
      "created #{created_at}"
    else
      name
    end
  end
end
