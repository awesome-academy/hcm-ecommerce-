class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :evaluates, dependent: :destroy
end
