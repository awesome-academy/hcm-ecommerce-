class StaticPagesController < ApplicationController
  def home
    @parents = Category.parents
  end
end
