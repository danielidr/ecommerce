class Product < ApplicationRecord
  has_and_belongs_to_many :categories

  has_many :order_items
  has_many :orders, through: :order_items

  has_many :products_variations, dependent: :destroy
  has_many :variations, through: :products_variations
end
