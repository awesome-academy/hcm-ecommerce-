class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details, dependent: :destroy
  has_many :evaluates, dependent: :destroy

  has_one_attached :image

  validates :image, content_type: {
    in: ["image/jpeg", "image/gif", "image/png"],
    message: I18n.t("common.error_message.type_image")
  },
  size: {
    less_than: 5.megabytes,
    message: I18n.t("common.error_message.length_image")
  }
  validates :name, presence: true, uniqueness: true
  validates :quatity, presence: true, numericality: {greater_than: -1}
  validates :category_id, presence: true, exclusion: {in: Category.childrens}
  validates :price, presence: true, numericality: {greater_than: -1}
  validates :description, presence: true

  scope :sort_update, ->{order(updated_at: :desc)}
end
