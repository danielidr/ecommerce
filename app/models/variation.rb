class Variation < ApplicationRecord
    has_many :products_variations, dependent: :destroy
    has_many :products, through: :products_variations

end
