class OrdersController < ApplicationController
  before_action :is_loggin?
  before_action :check_admin?
  before_action :load_order, only: [:edit, :update]

  def new
    redirect_to login_path unless loggin?
    @carts = summary_cart
    @sumary = @carts[-1]
    @carts.pop
  end

  def create
    ActiveRecord::Base.transaction do
      @order = current_user.orders.build(order_params)
      @order.save!
      create_order_detail @order[:id]
      flash[:success] = t "common.flash.order_success"
      session[:cart] = nil
      redirect_to root_path
    end
  rescue StandardError
    flash[:error] = t "common.flash.order_fail"
    redirect_to new_order_path
  end

  def update
    ActiveRecord::Base.transaction do
      @order.cancel_order
      flash[:success] = t "common.flash.cancel"
      redirect_to orders_path
    end
  rescue StandardError
    flash[:error] = t "common.flash.cancel_fail"
    redirect_to orders_path
  end

  def index
    @orders = Order.page(params[:page]).per(Settings.per_page)
                   .orders(current_user[:id]).sort_desc
    @result = load_data_to_view @orders
  end

  def edit
    @total = @order.order_details.reduce(0){|a, e| a + e[:price] * e[:quatity]}
  end

  private

  def load_order
    @order = Order.find_by(id: params[:id])
    return if @order

    flash[:error] = t "common.flash.load_order_fail"
    redirect_to orders_path
  end

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

  def create_order_detail order_id
    session[:cart].each do |x, y|
      product = Product.find_by(id: x)
      if product.nil?
        session[:cart].delete(k)
        next
      end

      product[:quatity] = product[:quatity] - y
      product.save!
      price = product[:price]
      new_detail = OrderDetail.new(detail_params(order_id, x, y, price))
      new_detail.save!
    end
  end

  def order_params
    params.require(:order).permit(:fullname, :phone_number, :address)
  end

  def detail_params order_id, product_id, quatity, price
    {
      order_id: order_id,
      product_id: product_id,
      quatity: quatity,
      price: price
    }
  end

  def is_loggin?
    store_location
    redirect_to login_path unless loggin?
  end
end
