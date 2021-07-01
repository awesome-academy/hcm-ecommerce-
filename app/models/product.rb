class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details, dependent: :destroy
  has_many :evaluates, dependent: :destroy

  scope :sort_update, ->{order(updated_at: :desc)}
end
