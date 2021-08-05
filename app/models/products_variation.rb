class ProductsVariation < ApplicationRecord
  belongs_to :product
  belongs_to :variation

  has_many :order_items
  has_many :orders, through: :order_items
end
