require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "should update cart with valid params" do
    cart = Cart.create!
    product = products(:gr1)

    patch cart_path(cart), params: {
      cart: {
        product_id: product.id,
        quantity: 1
      }
    }, as: :turbo_stream

    assert_response :success
    assert_equal cart.reload.cart_products.sum(:quantity), 1
  end

  test "should handle invalid params gracefully" do
    cart = Cart.create!
    product = products(:gr1)

    patch cart_path(cart), params: {
      cart: {
        product_id: product.id,
        quantity: -1
      }
    }, as: :turbo_stream

    assert_response :success
    assert_equal cart.reload.cart_products.sum(:quantity), 0
  end
end
