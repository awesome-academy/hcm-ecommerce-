class Admin::StaticPagesController < AdminController
  def dashboard
    @customer_number = User.customers.count
    @product_number = Product.count
    @order_number = Order.approved.count
    @total = 0
    @data_chart = Hash.new
    Order.approved.each do |o|
      @total += o.order_details.reduce(0){|a, e| a + e[:price] * e[:quatity]}
      @data_chart[o[:created_at].to_date] = @total
    end
  end
end
