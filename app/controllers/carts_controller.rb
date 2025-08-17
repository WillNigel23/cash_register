class CartsController < ApplicationController
  def update
    cart = Cart.find(params[:id])

    @result = Carts::Update.new(cart:, cart_params:).perform
    @items_count = @result.cart.cart_products.sum(:quantity)

    respond_to(&:turbo_stream)
  end

  def remove_product
    cart = Cart.find(params[:cart_id])
    @product = Product.find(params[:product_id])
    @result = Carts::RemoveProduct.new(cart:, product: @product).perform

    checkout_presenter = Carts::Calculate.new(cart: @result.cart).perform
    @items_count = checkout_presenter.items_count
    @order_products = checkout_presenter.order_products
    @total = checkout_presenter.total

    respond_to(&:turbo_stream)
  end

  private

  def cart_params
    params.require(:cart).permit(
      :product_id,
      :quantity
    )
  end
end
