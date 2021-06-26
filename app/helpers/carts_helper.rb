module CartsHelper
  def current_cart_number
    session[:cart]&.values&.inject(0, :+).to_i
  end
end
