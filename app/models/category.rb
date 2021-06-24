class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  belongs_to :parent, class_name: Category.name, optional: true
  has_many :childrens, class_name: Category.name, foreign_key: :parent_id,
                      dependent: :destroy

  scope :parents, ->{where("parent_id is null")}

  accepts_nested_attributes_for :childrens
end
