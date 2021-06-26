class CartsController < ApplicationController
  def create
    @current_cart = session[:cart] || Hash.new
    is_have = change_quatity? unless @current_cart.empty?
    @current_cart[params[:product_id]] = params[:quatity].to_i unless is_have
    session[:cart] = @current_cart
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js
    end
  end

  private

  def change_quatity?
    return false unless @current_cart[params[:product_id]]

    @current_cart[params[:product_id]] += params[:quatity].to_i
    true
  end
end
