class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :evaluates, dependent: :destroy

  has_secure_password

  class << self
    def digest token
      BCrypt::Password.create(token)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
