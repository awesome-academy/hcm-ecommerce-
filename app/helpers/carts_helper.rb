module CartsHelper
  def current_cart_number
    session[:cart]&.values&.inject(0, :+).to_i
  end

  def summary_cart
    carts = []
    sumary = 0
    session[:cart]&.each do |k, v|
      product = Product.find_by(id: k)
      unless product
        session[:cart].delete(k)
        next
      end

      total = v * product[:price]
      sumary += total
      cart = {
        name: product[:name],
        quatity: v,
        price: product[:price],
        total: total,
        id: product[:id]
      }
      carts << cart
    end
    carts << sumary
  end
end
