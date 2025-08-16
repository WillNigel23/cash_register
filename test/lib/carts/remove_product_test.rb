require "test_helper"

class Carts::RemoveProductTest < ActiveSupport::TestCase
  fixtures :products

  test "removes existing product" do
    cart = Cart.create!
    product = products(:gr1)
    cart.products << product

    assert_includes cart.reload.products, product
    assert_equal cart.cart_products.sum(:quantity), 1

    result = Carts::RemoveProduct.new(cart:, product:).perform

    assert result.success
    assert_equal result.cart.cart_products.sum(:quantity), 0
  end

  test "graceful error when removing non-existing product" do
    cart = Cart.create!
    product = products(:gr1)

    product_2 = products(:cf1)
    cart.products << product_2

    assert_equal cart.cart_products.sum(:quantity), 1

    result = Carts::RemoveProduct.new(cart:, product:).perform

    assert_not result.success
    assert_equal result.cart.cart_products.sum(:quantity), 1
  end
end
