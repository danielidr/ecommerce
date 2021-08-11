require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test 'creates a random number on create' do
    user = User.create(email: "user@example.com", password: "12345678")
    order = Order.create(user_id: user.id)
    assert !order.number.nil?
  end

  test 'number must be unique' do
    user = User.create(email: "user@example.com", password: "12345678")
    order = Order.create(user_id: user.id)
    duplicated_order = order.dup
    assert_not duplicated_order.valid?
  end

  test 'add products as order_items' do
    user = User.create(email: "user@example.com", password: "12345678")
    order = Order.create(user_id: user.id)
    
    product = Product.create(name: "test", price: 1.0, stock: 10, sku: "001")
    variation = Variation.create(size: "S", color: "Black")
    product_var = ProductsVariation.create(product_id: product.id, variation_id: variation.id, stock: 5)
    order.add_product(product_var.product.id, 1)
    assert_equal order.order_items.count, 1
  end

  test 'products with stock zero cant be added to cart' do
    user = User.create(email: "user@example.com", password: "12345678")
    order = Order.create(user_id: user.id)

    product = Product.create(name: "test", price: 1, stock: 0, sku: "001")
    variation = Variation.create(size: "S", color: "Black")
    product_var = ProductsVariation.create(product_id: product.id, variation_id: variation.id, stock: 0)
    order.add_product(product_var.product.id, 1)

    assert_equal order.order_items.count, 0
  end

  test 'payment creation successfully' do
    user = User.create(email: "test@test.com", password: "123456")
    order = Order.create(user_id: user.id)
    payment_method = PaymentMethod.create(name: "Paypal Express Checkout", code: "PEC")
    
    order.payment_creation("test")
    payment = Payment.find_by(token: "test")

    assert_not payment.nil?
  end

  test ' check response for purchase_preparation' do
    user = User.create(email: "test@test.com", password: "123456")
    order = Order.create(user_id: user.id)
    response = order.purchase_preparation(100, "123456")
    assert response?
  end 

end
