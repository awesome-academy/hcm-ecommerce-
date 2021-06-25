class StaticPagesController < ApplicationController
  def home
    @parents = Category.parents
    @products = Product.all.sort_by{|x| -x.order_details.count}[0..8]
  end
end
