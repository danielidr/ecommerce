require 'test_helper'

class PaymentTest < ActiveSupport::TestCase

  test 'add options with get_purchase_options' do
    payer_id = 20
    ip = "192.168.10.6"
    payment = Payment.create(order_id: 1, payment_method_id: 1, state: "in process", total: 100.5, token: "test")
    pay = payment.get_purchase_options(payer_id, payment.token, ip)

    pay_ok = {
      ip: ip,
      token: payment.token,
      payer_id: payer_id,
      currency: "USD"
    }

    assert pay == pay_ok
  end

  test 'process_paypal_payment successfully' do
    payer_id = 20
    ip = "192.168.10.6"
    user = User.create(email: "test@test.com", password: "123456")
    order = Order.create(user_id: 1, number: "200", total: 100.5, state: "created")
    payment = Payment.create(payment_method_id: 1, state: "in process", total: order.total, token: "test")
    order.user = user
    payment.order = order
    method = PaymentMethod.create(name: "Paypal Express Checkout", code: "PEC")
    payment.payment_method = method
    payment.process_paypal_payment(payment.total, payer_id, payment.token, ip)
    
    assert payment.state == "completed"
  end

end
