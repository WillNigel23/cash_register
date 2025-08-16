require "test_helper"

class Carts::CalculateTest < ActiveSupport::TestCase
  fixtures :products

  test "should have correct calculation price case 0" do
    cart = Cart.create!

    presenter = Carts::Calculate.new(cart:).perform

    assert_equal presenter.order_products.flat_map(&:product), []
    assert_equal presenter.total, 0
  end

  test "should have correct calculation price case 1" do
    cart = Cart.create!

    CartProduct.create!(cart_id: cart.id, product_id: products(:gr1).id, quantity: 3)
    CartProduct.create!(cart_id: cart.id, product_id: products(:cf1).id, quantity: 1)
    CartProduct.create!(cart_id: cart.id, product_id: products(:sr1).id, quantity: 1)

    presenter = Carts::Calculate.new(cart:).perform

    expected_products = [ products(:gr1), products(:cf1), products(:sr1) ].sort
    presenter_products = presenter.order_products.map(&:product).sort

    assert_equal presenter_products.sort, expected_products
    assert_equal presenter.total, 22.45
  end

  test "should have correct calculation price case 2" do
    cart = Cart.create!

    CartProduct.create!(cart_id: cart.id, product_id: products(:gr1).id, quantity: 2)

    presenter = Carts::Calculate.new(cart:).perform

    expected_products = [ products(:gr1) ]
    presenter_products = presenter.order_products.map(&:product)

    assert_equal presenter_products.sort, expected_products
    assert_equal presenter.total, 3.11
  end

  test "should have correct calculation price case 3" do
    cart = Cart.create!

    CartProduct.create!(cart_id: cart.id, product_id: products(:gr1).id, quantity: 1)
    CartProduct.create!(cart_id: cart.id, product_id: products(:sr1).id, quantity: 3)

    presenter = Carts::Calculate.new(cart:).perform

    expected_products = [ products(:gr1), products(:sr1) ].sort
    presenter_products = presenter.order_products.map(&:product).sort

    assert_equal presenter_products, expected_products
    assert_equal presenter.total, 16.61
  end

  test "should have correct calculation price case 4" do
    cart = Cart.create!

    CartProduct.create!(cart_id: cart.id, product_id: products(:gr1).id, quantity: 1)
    CartProduct.create!(cart_id: cart.id, product_id: products(:sr1).id, quantity: 1)
    CartProduct.create!(cart_id: cart.id, product_id: products(:cf1).id, quantity: 3)

    presenter = Carts::Calculate.new(cart:).perform

    expected_products = [ products(:gr1), products(:cf1), products(:sr1) ].sort
    presenter_products = presenter.order_products.map(&:product).sort

    assert_equal presenter_products, expected_products
    assert_equal presenter.total, 30.57
  end
end
