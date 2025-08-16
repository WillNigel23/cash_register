class Carts::Update
  attr_accessor :cart, :product, :success

  def initialize(cart:, cart_params:)
    @cart        = cart
    @cart_params = cart_params
    @success     = true
  end

  def perform
    ensure_valid_params

    @product = Product.find(@cart_params[:product_id])
    cart_product = @cart.cart_products.find_or_initialize_by(product_id: @product.id)
    cart_product.quantity = 0 unless cart_product.persisted?
    cart_product.quantity += parsed_quantity
    cart_product.save!

    self
  rescue StandardError => _e
    @success = false

    self
  end

  private

  def ensure_valid_params
    raise ArgumentError, "product_id is required param!" if @cart_params[:product_id].blank?
    raise ArgumentError, "quantity is required param!" if @cart_params[:quantity].blank?
    raise ArgumentError, "quantity must be > 0" unless parsed_quantity.positive?
  end

  def parsed_quantity
    @parsed_quantity ||= ActiveModel::Type::Integer.new.cast(@cart_params[:quantity])
  end
end
