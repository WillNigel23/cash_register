require "test_helper"

class Carts::UpdateTest < ActiveSupport::TestCase
  fixtures :products

  test "adds a product with default quantity" do
    cart = Cart.create!
    product = products(:gr1)
    cart_params = {
      product_id: product.id,
      quantity: 1
    }
    result = Carts::Update.new(cart:, cart_params:).perform

    assert result.success
    assert_equal result.cart.cart_products.sum(:quantity), 1
    assert_includes result.cart.products, product
  end

  test "adds existing product " do
    cart = Cart.create!
    product = products(:gr1)
    cart.products << product

    cart_params = {
      product_id: product.id,
      quantity: 1
    }
    result = Carts::Update.new(cart:, cart_params:).perform

    assert result.success
    assert_equal result.cart.cart_products.sum(:quantity), 2
    assert_includes result.cart.products, product
  end

  test "graceful error when product_id is missing" do
    cart = Cart.create!
    cart_params = {
      quantity: 1
    }
    result = Carts::Update.new(cart:, cart_params:).perform

    assert_not result.success
    assert_equal result.cart.cart_products.sum(:quantity), 0
  end

  test "graceful error when product_id is malformed" do
    cart = Cart.create!
    cart_params = {
      product_id: "non-existent-id",
      quantity: 1
    }
    result = Carts::Update.new(cart:, cart_params:).perform

    assert_not result.success
    assert_equal result.cart.cart_products.sum(:quantity), 0
  end

  test "graceful error when quantity is missing" do
    cart = Cart.create!
    product = products(:gr1)
    cart_params = {
      product_id: product.id
    }
    result = Carts::Update.new(cart:, cart_params:).perform

    assert_not result.success
    assert_equal result.cart.cart_products.sum(:quantity), 0
  end

  test "graceful error when quantity is malformed" do
    cart = Cart.create!
    product = products(:gr1)
    cart_params = {
      product_id: product.id,
      quantity: -1
    }
    result = Carts::Update.new(cart:, cart_params:).perform

    assert_not result.success
    assert_equal result.cart.cart_products.sum(:quantity), 0
  end
end
