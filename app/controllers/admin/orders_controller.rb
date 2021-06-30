class Admin::OrdersController < AdminController
  before_action :load_order, only: [:edit, :update]

  def index
    @orders = Order.page(params[:page]).per(Settings.per_page).sort_desc
    @result = load_data_to_view @orders
  end

  def edit
    @total = @order.order_details.reduce(0){|a, e| a + e[:price] * e[:quatity]}
  end

  def update
    ActiveRecord::Base.transaction do
      if params[:status].to_i == Order.statuses[:approved]
        @order.approve_order
      elsif params[:status].to_i == Order.statuses[:rejected]
        @order.reject_order
      end
      update_success
    end
  rescue StandardError
    flash[:error] = t "common.flash.order_fail"
    redirect_to admin_orders_path
  end

  private

  def load_data_to_view orders
    orders = orders.select(:id, :created_at, :status, :fullname, :phone_number)
    orders.includes(:order_details).map do |order|
      quatity = 0
      price = 0
      order.order_details.each do |d|
        quatity += d.quatity
        price += quatity * d.price
      end
      {
        order_quatity: quatity,
        price: price,
        status: order[:status],
        order_time: order[:created_at],
        order_id: order[:id],
        fullname: order[:fullname],
        phone_number: order[:phone_number]
      }
    end
  end

  def update_success
    message = t("common.flash.#{params[:status] == '1' ? 'approve' : 'reject'}")
    flash[:success] = message
    redirect_to admin_orders_path
  end

  def load_order
    @order = Order.find_by(id: params[:id])
    return if @order

    flash[:error] = t "common.flash.load_order_fail"
    redirect_to admin_orders_path
  end
end
