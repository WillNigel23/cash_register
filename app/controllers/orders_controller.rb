class OrdersController < ApplicationController
  def new
    checkout_presenter = Carts::Calculate.new(
      cart: @current_cart
    ).perform

    @order = Order.new
    @order_products = checkout_presenter.order_products
    @total = checkout_presenter.total
  end

  def create
    result = Orders::Create.new(
      order_params:,
      cart: @current_cart
    ).perform

    if result.success
      flash[:notice] = t("order_created")
      redirect_to root_path(format: :html)
    else
      @order = result.order
      @order_products = result.checkout_presenter.order_products
      @total = result.checkout_presenter.total

      respond_to(&:turbo_stream)
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :name,
      :address
    )
  end
end
