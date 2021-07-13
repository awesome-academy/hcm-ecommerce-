class ProductsController < ApplicationController
  def edit
    @product = Product.find_by(id: params[:id])
    store_location
  end
end
