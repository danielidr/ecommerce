class OrderItem < ApplicationRecord
  belongs_to :products_variation
  belongs_to :order
end
