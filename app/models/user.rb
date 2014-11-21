class User < ActiveRecord::Base
  # NB an Account is created when a new User is saved (after_create)
  # has_many :accounts, dependent: :restrict_with_exception
  has_many   :accounts, dependent: :destroy
  belongs_to :current_account, class: Account # todo:later inverse_of: :current, dependent: :nullify
  has_many   :sessions, dependent: :destroy

  has_secure_password

  enum status: { initial: 1, active: 2, suspended: 3 }

  after_initialize :default_values, unless: :persisted?

  before_save { self.email.downcase! }
  after_create :create_account
  after_update :update_account

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :status, presence: true

  # class SecurityError < StandardError::SecurityError
  # end

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def find_account_for_display!(id)
    raise 'no id specified for account' unless id

    begin
      account = Account.find(id)
      return account if self.admin?
      return account if account.public?
      return account if account.user == self
      raise SecurityError
    rescue ActiveRecord::RecordNotFound, SecurityError
      raise SecurityError, 'account not known or not allowed for this user'
    end
  end

  def find_account_for_update!(id)
    raise 'no id specified for account' unless id

    begin
      account = Account.find(id)
      return account if self.admin?
      return account if account.user == self
      raise SecurityError
    rescue ActiveRecord::RecordNotFound, SecurityError
      raise SecurityError, 'account not known or not allowed for this user'
    end
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    self.relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    self.relationships.find_by(followed_id: other_user.id).destroy
  end

  def display_name
    if name.blank?
      "created #{created_at}"
    else
      name
    end
  end

  private

  # def initialize(attributes={})
  def default_values
    # super
    # self.status ||= :initial      # self.status = :initial if self.status.nil?    Or... consider a "before_create"?
    self.status ||= :initial if self.has_attribute? :status
  end

  def create_account
    # Rails.logger.debug('user.create_account starts')

    # raise 'user is admin' if self.admin?

    self.current_account = self.accounts.create!(name: self.name,
                                                 public: self.admin? ? true : false,     # todo:later doesn't seem to work
                                                 status: self.status)

    raise 'current_account is nil' if self.current_account.nil?
    raise 'current_account_id is nil' if self.current_account_id.nil?

    self.save!

    # Rails.logger.debug(self.inspect)
    # Rails.logger.debug(self.accounts.inspect)
    # Rails.logger.debug('user.create_account ends')
  end

  def update_account
    account = self.current_account
    # account = self.accounts.first
    raise 'account is nil' if account.nil?
    # raise "account is not nil #{account} // #{self.name} / #{account.name} // #{self.status} / #{account.status}"
    if account.name != self.name || !account.public? != !self.admin? || account.status != self.status
      account.update!(name: self.name,
                      public: self.admin? ? true : false,     # todo:later doesn't seem to work
                      status: self.status.to_s
                      )
    end
    # raise 'account is not public' if self.admin? && !account.public?
    # raise "account is not nil #{account} // #{self.name} / #{account.name} // #{self.status} / #{account.status}"
  end
end
