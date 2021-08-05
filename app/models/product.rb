class Product < ApplicationRecord
  has_and_belongs_to_many :categories

  has_many :products_variations, dependent: :destroy
  has_many :variations, through: :products_variations

  def show_variant
    if not products_variations.blank?
      products_variations.each do |products_variation|
        if products_variation.stock > 0
          return products_variation
        end
      end
    else
      return "The product doesnt have any variants"
    end
    "Out of stock"
  end
  
end
