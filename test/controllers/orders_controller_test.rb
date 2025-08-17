require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "should show correct price case 0" do
    get new_order_path

    assert_response :success

    assert_includes @response.body, "0.00€"
  end

  test "should show correct price case 1" do
    # This is to initialize session[:cart_id]
    get root_url

    cart = Cart.last
    CartProduct.create!(cart_id: cart.id, product_id: products(:gr1).id, quantity: 3)
    CartProduct.create!(cart_id: cart.id, product_id: products(:cf1).id, quantity: 1)
    CartProduct.create!(cart_id: cart.id, product_id: products(:sr1).id, quantity: 1)

    get new_order_path

    assert_response :success

    assert_includes @response.body, "22.45€"
  end

  test "should show correct price case 2" do
    # This is to initialize session[:cart_id]
    get root_url

    cart = Cart.last
    CartProduct.create!(cart_id: cart.id, product_id: products(:gr1).id, quantity: 2)

    get new_order_path

    assert_response :success

    assert_includes @response.body, "3.11€"
  end

  test "should show correct price case 3" do
    # This is to initialize session[:cart_id]
    get root_url

    cart = Cart.last
    CartProduct.create!(cart_id: cart.id, product_id: products(:gr1).id, quantity: 1)
    CartProduct.create!(cart_id: cart.id, product_id: products(:sr1).id, quantity: 3)

    get new_order_path

    assert_response :success

    assert_includes @response.body, "16.61€"
  end

  test "should show correct price case 4" do
    # This is to initialize session[:cart_id]
    get root_url

    cart = Cart.last
    CartProduct.create!(cart_id: cart.id, product_id: products(:gr1).id, quantity: 1)
    CartProduct.create!(cart_id: cart.id, product_id: products(:sr1).id, quantity: 1)
    CartProduct.create!(cart_id: cart.id, product_id: products(:cf1).id, quantity: 3)

    get new_order_path

    assert_response :success

    assert_includes @response.body, "30.57€"
  end

  test "should create order and clear cart" do
    # This is to initialize session[:cart_id]
    get root_url

    cart = Cart.last
    product = products(:gr1)
    cart.products << product

    post orders_path, params: {
      order: {
        name: "Customer Name",
        address: "Customer Address"
      }
    }, as: :turbo_stream

    assert_response :redirect
    assert_redirected_to root_path(format: :html)
  end

  test "should graceful fail order and present errors" do
    post orders_path, params: {
      order: {
        name: "",
        address: ""
      }
    }, as: :turbo_stream

    assert_response :success

    html = CGI.unescapeHTML(@response.body)
    assert_includes html, "Name can't be blank"
    assert_includes html, "Address can't be blank"
    assert_includes html, "Products must be at least 1"
  end
end
