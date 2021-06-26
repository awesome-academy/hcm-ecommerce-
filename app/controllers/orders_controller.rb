class OrdersController < ApplicationController
  before_action :is_loggin?

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
    redirect_to new_checkout_path
  end

  private

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
