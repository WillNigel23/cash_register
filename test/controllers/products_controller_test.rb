require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "should get index with no products" do
    Product.destroy_all

    get products_url

    assert_response :success

    assert_includes @response.body, "No products available"
  end

  test "should get index" do
    products = [ products(:gr1), products(:sr1), products(:cf1) ]

    get products_url

    assert_response :success

    products.each do |product|
      assert_includes @response.body, product.name
    end
  end
end
