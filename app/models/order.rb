class Order < ApplicationRecord
  before_create :defaul_status

  belongs_to :user
  has_many :order_details, dependent: :destroy

  scope :sort_desc, ->{order(created_at: :desc)}

  enum status: {pending: 0, approved: 1, cancel: 2, rejected: 3}

  def reject_order
    rejected!
    order_details.each do |d|
      d.product.update!(quatity: d.product[:quatity] + d[:quatity])
    end
  end

  def approve_order
    approved!
  end

  private

  def defaul_status
    self.status = 0 if status.nil?
  end
end
