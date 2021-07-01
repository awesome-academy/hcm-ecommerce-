class Order < ApplicationRecord
  before_create :defaul_status

  belongs_to :user
  has_many :order_details, dependent: :destroy

  scope :sort_desc, ->{order(created_at: :desc)}
  scope :approved, ->{where(status: 1)}
  scope :orders, ->(user_id){where(user_id: user_id)}

  enum status: {pending: 0, approved: 1, cancel: 2, rejected: 3}

  def reject_order
    rejected!
    refund_quatity
  end

  def approve_order
    approved!
  end

  def cancel_order
    cancel!
    refund_quatity
  end

  def refund_quatity
    order_details.each do |d|
      d.product.update!(quatity: d.product[:quatity] + d[:quatity])
    end
  end

  private

  def defaul_status
    self.status = 0 if status.nil?
  end
end
