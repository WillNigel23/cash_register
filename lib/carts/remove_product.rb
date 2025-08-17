class Carts::RemoveProduct
  attr_accessor :cart, :product, :success

  def initialize(cart:, product:)
    @cart    = cart
    @product = product
    @success = true
  end

  def perform
    @cart.cart_products.find_by(product_id: @product.id).destroy!

    self
  rescue StandardError => _e
    @success = false

    self
  end
end
