require "test_helper"

class OrderTest < ActiveSupport::TestCase
  fixtures :products

  test "should not save without name" do
    order = Order.new(address: "Customer Address")
    assert_not order.valid?
    assert_includes order.errors[:name], "can't be blank"
  end

  test "should not save without address" do
    order = Order.new(name: "Customer Name")
    assert_not order.valid?
    assert_includes order.errors[:address], "can't be blank"
  end

  test "should have many products" do
    assoc = Order.reflect_on_association(:products)
    assert_equal :has_many, assoc.macro
  end
end
