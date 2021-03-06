class StaticPagesController < ApplicationController
  before_action :check_admin?

  def home
    @parents = Category.parents
    @products = Product.all.sort_by{|x| -x.order_details.count}[0..7]
  end
end
