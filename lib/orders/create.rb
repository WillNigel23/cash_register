class Orders::Create
  attr_accessor :order, :checkout_presenter, :success

  def initialize(order_params:, cart:)
    @order_params = order_params
    @cart = cart
    @success = true
  end

  def perform
    @order = Order.new(@order_params)
    @checkout_presenter = Carts::Calculate.new(cart: @cart).perform
    @order.order_products = @checkout_presenter.order_products

    ensure_valid_order

    ActiveRecord::Base.transaction do
      @order.save!
      @cart.cart_products.destroy_all
    end

    self
  rescue StandardError => _e
    @success = false

    self
  end

  private

  def ensure_valid_order
    @order.valid?

    unless @order.order_products.size > 0
      @order.errors.add(:products, I18n.t("errors.at_least_one"))
    end

    raise ArgumentError, "invalid order" if @order.errors.any?
  end
end
