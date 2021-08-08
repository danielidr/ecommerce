require 'test_helper'

class PaymentTest < ActiveSupport::TestCase

  test 'add options with get_purchase_options' do
    payer_id = 20
    ip = "192.168.10.6"
    payment = Payment.create(order_id: 1, payment_method_id: 1, state: "in process", total: 100.5, token: "test")
    pay = payment.get_purchase_options(payer_id, payment.token, ip)

    assert pay[:ip] == ip
    assert pay[:payer_id] == payer_id
    assert pay[:token] == payment.token
    assert pay[:currency] == "USD"
    
  end
end
