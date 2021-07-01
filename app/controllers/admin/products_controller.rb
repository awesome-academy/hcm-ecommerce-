class Admin::ProductsController < AdminController
  before_action :load_category, only: [:create]
  before_action :load_childrens, only: [:new, :create]

  def index
    @products = Product.page(params[:page]).per(Settings.per_page).sort_update
  end

  def new
    @products = Product.new
  end

  def create
    @products = @category.products.build(product_params)
    if @products.save
      @products.image.attach(params[:product][:image])
      flash[:success] = t("common.flash.create_product_success")
      redirect_to admin_products_path
    else
      render :new
    end
  end

  private

  def load_category
    @category = Category.find_by(id: params[:product][:category_id])
    return if @category

    flash[:error] = t "common.flash.load_category_fail"
    redirect_to new_admin_product
  end

  def load_childrens
    @categories = Category.childrens.select(:name, :id)
  end

  def product_params
    params
      .require(:product)
      .permit(:name, :quatity, :price, :image, :description)
  end
end
