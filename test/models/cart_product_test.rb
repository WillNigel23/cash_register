require "test_helper"

class CartProductTest < ActiveSupport::TestCase
  test "should have quantity > 1" do
    cart = Cart.create!
    product = products(:gr1)

    cart_product = CartProduct.create(cart: cart, product: product, quantity: 0)
    assert_not cart_product.valid?
    assert_includes cart_product.errors[:quantity], "must be greater than 0"
  end

  test "should only be able to add unique products" do
    cart = Cart.create!
    product = products(:gr1)

    cart_product = CartProduct.create(cart: cart, product: product, quantity: 1)
    assert cart_product.valid?

    duplicate = CartProduct.new(cart: cart, product: product, quantity: 1)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:product_id], "has already been taken"
  end
end
