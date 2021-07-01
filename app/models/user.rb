class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :orders, dependent: :destroy
  has_many :evaluates, dependent: :destroy

  enum role: {user: 0, admin: 1}

  scope :customers, ->{where("id IN (select DISTINCT user_id from orders)")}

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true, allow_nil: true

  def authenticate? attribute, token
    digest = send("#{attribute}_digest")
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  def remember
    remember_token = User.new_token
    update_column(:remember_digest, User.digest(remember_token))
  end

  def forgot
    update_column(:remember_digest, nil)
  end

  class << self
    def digest token
      BCrypt::Password.create(token)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
