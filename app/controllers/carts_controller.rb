class CartsController < ApplicationController
  before_action :authenticate_user!

  def update
    product = params[:cart][:product_id]
    quantity = params[:cart][:quantity]

    current_order.add_product(product, quantity)

    redirect_to root_url, notice: "Product added successfuly"
  end

  def show
    @order = current_order
  end

  def pay_with_paypal
    order = Order.find(params[:cart][:order_id])
    response = order.purchase_preparation(order.response, request.remote_ip)
    order.payment_creation(response.token)
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  def process_paypal_payment
    details = EXPRESS_GATEWAY.details_for(params[:token])
    price = details.params["order_total"].to_d * 100
    payment = Payment.find_by(token: response.token)
    token = params[:token]
    payment.process_paypal_payment(price, details.payer_id, token, request.remote_ip)
  end
end
