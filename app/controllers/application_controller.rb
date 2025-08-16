class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :set_current_cart

  private

  def set_current_cart
    if session[:cart_id].present?
      @current_cart = Cart.find_by(id: session[:cart_id])
    end

    @current_cart ||= Cart.create!
    session[:cart_id] = @current_cart.id

    @current_cart_count = @current_cart.cart_products.sum(:quantity)
  end
end
