class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :payment_method

  def get_purchase_options(payer_id, token, ip)
      {
        ip: ip,
        token: token,
        payer_id: payer_id,
        currency: "USD"
      }
  end

  def process_paypal_payment(price, payer_id, token, ip)
    response = EXPRESS_GATEWAY.purchase(price, get_purchase_options(payer_id, token, ip))
    if response.success?
      order = self.order
      self.state = "completed"
      order.state = "completed"

      ActiveRecord::Base.transaction do
        order.save!
        save!
      end
    end
  end
end
