class OrdersController < ApplicationController
  def new
    checkout_presenter = Carts::Calculate.new(
      cart: @current_cart
    ).perform

    @order = Order.new
    @order_products = checkout_presenter.order_products
    @total = checkout_presenter.total
  end
end
