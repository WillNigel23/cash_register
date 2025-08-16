class Carts::Calculate
  attr_accessor :order_products, :items_count, :total

  def initialize(cart:)
    @cart           = cart
    @order_products = []
    @items_count    = 0
    @total          = 0
  end

  def perform
    @cart.cart_products.includes(:product).each do |cart_product|
      actual_price = calculate_actual_price(cart_product).round(2)
      @items_count += cart_product.quantity
      @total += actual_price
      order_product = OrderProduct.new(
        product_id: cart_product.product_id,
        quantity: cart_product.quantity,
        actual_price:
      )

      @order_products << order_product
    end

    self
  end

  private

  def calculate_actual_price(cart_product)
    product = cart_product.product
    case product.code
    when "GR1" # Buy 1 Take 1
      quantity = (cart_product.quantity / 2.0).ceil

      quantity * product.price
    when "SR1" # Buy 3, each item will cost 4.50
      each_price = cart_product.quantity > 2 ? 4.50 : product.price

      cart_product.quantity * each_price
    when "CF1"
      discount_percentage = cart_product.quantity > 2 ? (2.0 / 3.0) : 1

      (product.price * cart_product.quantity) * discount_percentage
    end
  end
end
