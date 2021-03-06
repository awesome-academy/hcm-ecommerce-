class CartsController < ApplicationController
  before_action :check_admin?
  before_action :current_cart

  def create
    product_id = @current_cart[params[:product_id]].to_i
    if enough_quatity? params[:product_id], product_id + params[:quatity].to_i
      add_product_to_cart
    else
      flash[:error] = t "common.flash.quantity_invalid"
      redirect_to session[:forwarding_url] || root_path
    end
  end

  def update
    if @current_cart[params[:id]]
      new_total = @current_cart[params[:id]] + params[:cal].to_i
      change_total @current_cart, new_total
    end
    session[:cart] = @current_cart
    redirect_to new_cart_path
  end

  def new
    store_location
    @carts = summary_cart
    @sumary = @carts[-1]
    @carts.pop
  end

  def destroy
    @current_cart.delete(params[:id])
    session[:cart] = @current_cart
    redirect_to new_cart_path
  end

  private

  def add_product_to_cart
    is_have = change_quatity? unless @current_cart.empty?
    @current_cart[params[:product_id]] = params[:quatity].to_i unless is_have
    session[:cart] = @current_cart
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js
    end
  end

  def change_total cart, total
    if enough_quatity?(params[:id], total)
      cart[params[:id]] = total
    else
      flash[:error] = t "common.flash.quantity_invalid"
    end
  end

  def change_quatity?
    return false unless @current_cart[params[:product_id]]

    @current_cart[params[:product_id]] += params[:quatity].to_i
  end

  def current_cart
    @current_cart = session[:cart] || Hash.new
  end

  def enough_quatity? product_id, quatity
    product = Product.find_by(id: product_id)
    quatity.positive? && quatity <= product[:quatity] if product
  end
end
