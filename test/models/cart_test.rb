require "test_helper"

class CartTest < ActiveSupport::TestCase
  fixtures :products

  test "should have many products" do
    assoc = Cart.reflect_on_association(:products)
    assert_equal :has_many, assoc.macro
  end
end
