class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  before_save do
    self.email.downcase!
  end
  default_scope {order('id ASC')}
  has_secure_password
  validates :name, :email, presence: true
  validates :email, uniqueness: {case_sensitive: false}, format: {with: EMAIL_REGEX}

  has_many :seeks
  has_many :likes, dependent: :destroy
  has_many :seeks_liked, through: :likes, source: :seek
end
