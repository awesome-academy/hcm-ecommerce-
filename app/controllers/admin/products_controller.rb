class Admin::ProductsController < AdminController
  before_action :load_category, only: [:create]
  before_action :load_product, only: [:edit, :update, :destroy]
  before_action :load_childrens, only: [:new, :create, :edit, :update]

  def index
    @products = Product.page(params[:page]).per(Settings.per_page)
                       .active.sort_update
  end

  def new
    @product = Product.new
  end

  def create
    @product = @category.products.build(product_params)
    if @product.save
      @product.image.attach(params[:product][:image])
      flash[:success] = t("common.flash.create_product_success")
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      image = params[:product][:image]
      @product.image.attach(image) unless image.nil?
      flash[:success] = t "common.flash.update_product_success"
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    if @product.update(deleted: true)
      flash[:success] = t "common.flash.delete_product_success"
    else
      flash[:error] = t "common.flash.delete_product_fail"
    end
    redirect_to admin_products_path
  end

  private

  def load_product
    @product = Product.find_by(id: params[:id])
    return if @product

    flash[:error] = t "common.flash.load_product_fail"
    redirect_to admin_products_path
  end

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
