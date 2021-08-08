class Order < ApplicationRecord
  before_create -> { generate_number(hash_size) }

  belongs_to :user

  has_many :order_items
  has_many :products_variations, through: :order_items
  has_many :payments

  validates :number, uniqueness: true

  def generate_number(size)
    self.number ||= loop do
      random = random_candidate(size)
      break random unless self.class.exists?(number: random)
    end
  end

  def random_candidate(size)
    "#{hash_prefix}#{Array.new(size){rand(size)}.join}"
  end

  def hash_prefix
    "BO"
  end

  def hash_size
    9
  end

  def add_product(product_id, quantity)
    product = Product.find(product_id)
    if product && (product.stock > 0)
      order_items.create(product_id: product.id, quantity: quantity, price: product.price)
      compute_total
    end
  end

  def compute_total
    sum = 0
    order_items.each do |item|
      sum += item.price
    end
    update_attribute(:total, sum)
  end

  def purchase_preparation(total, remote_ip)
    price = total * 100

    @response = EXPRESS_GATEWAY.setup_purchase(price,
      ip: remote_ip,
      return_url: process_paypal_payment_cart_url,
      cancel_return_url: root_url,
      allow_guest_checkout: true,
      currency: "USD"
    )
    @response
  end

  def payment_creation(token)
    payment_method = PaymentMethod.find_by(code: "PEC")
    
    Payment.create(
      order_id: self.id,
      payment_method_id: payment_method.id,
      state: "processing",
      total: self.total,
      token: token
    )
  end 
  
end
