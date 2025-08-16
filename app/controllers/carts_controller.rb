class CartsController < ApplicationController
  def update
    cart = Cart.find(params[:id])

    @result = Carts::Update.new(cart:, cart_params:).perform
    @items_count = @result.cart.cart_products.sum(:quantity)

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
