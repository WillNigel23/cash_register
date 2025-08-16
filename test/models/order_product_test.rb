require "test_helper"

class OrderProductTest < ActiveSupport::TestCase
  test "should have quantity > 1" do
    order = Order.create!(name: "Customer Name", address: "Customer Address")
    product = products(:gr1)

    order_product = OrderProduct.create(order: order, product: product, quantity: 0)
    assert_not order_product.valid?
    assert_includes order_product.errors[:quantity], "must be greater than 0"
  end

  test "should only be able to add unique products" do
    order = Order.create!(name: "Customer Name", address: "Customer Address")
    product = products(:gr1)

    order_product = OrderProduct.create(order: order, product: product, quantity: 1)
    assert order_product.valid?

    duplicate = OrderProduct.new(order: order, product: product, quantity: 1)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:product_id], "has already been taken"
  end
end
