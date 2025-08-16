class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :set_current_cart

  def current_cart
    @_current_cart
  end

  private

  def set_current_cart
    if session[:cart_id].present?
      @_current_cart = Cart.find_by(id: session[:cart_id])
    end

    @_current_cart ||= Cart.create!
    session[:cart_id] = @_current_cart.id
  end
end
