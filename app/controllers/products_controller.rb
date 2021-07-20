class ProductsController < ApplicationController
  before_action :load_product

  def edit
    store_location
  end

  private

  def load_product
    @product = Product.find_by(id: params[:id])
    return if @product

    flash[:error] = t "common.flash.load_product_fail"
    redirect_to root_path
  end
end
