require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "should not save without name" do
    product = Product.new(code: "YT1")
    assert_not product.valid?
    assert_includes product.errors[:name], "can't be blank"
  end

  test "should not save without code" do
    product = Product.new(name: "Yellow Tea")
    assert_not product.valid?
    assert_includes product.errors[:code], "can't be blank"
  end

  test "should have unique name and code" do
    product = Product.new(name: "Green Tea", code: "GR1")
    assert_not product.valid?
    assert_includes product.errors[:name], "has already been taken"
    assert_includes product.errors[:code], "has already been taken"
  end

  test "should have many carts" do
    assoc = Product.reflect_on_association(:carts)
    assert_equal :has_many, assoc.macro
  end
end
