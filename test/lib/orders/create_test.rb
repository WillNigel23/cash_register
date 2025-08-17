require "test_helper"

class Orders::CreateTest < ActiveSupport::TestCase
  fixtures :products

  test "creates valid order and clears cart" do
    cart = Cart.create!
    product = products(:gr1)
    cart.products << product

    order_params = {
      name: "Customer Name",
      address: "Customer Address"
    }
    result = Orders::Create.new(order_params:, cart:).perform

    assert result.success
    assert_includes result.order.products, product
    assert cart.reload.products.none?
  end

  test "graceful error when invalid order and preserves cart" do
    cart = Cart.create!
    product = products(:gr1)
    cart.products << product

    order_params = {
      name: "",
      address: ""
    }
    result = Orders::Create.new(order_params:, cart:).perform

    assert_not result.success
    assert_not result.order.persisted?
    assert_includes cart.reload.products, product
  end
end
