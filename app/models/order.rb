class Order < ApplicationRecord
  before_create :defaul_status

  belongs_to :user
  has_many :order_details, dependent: :destroy

  enum status: {pending: 0, approved: 1, cancel: 2, rejected: 3}

  private

  def defaul_status
    self.status = 0 if status.nil?
  end
end
