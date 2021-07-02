class Admin::ProductsController < AdminController
  def index
    @products = Product.page(params[:page]).per(Settings.per_page).sort_update
  end
end
