class AddOrdenItemProductsVariationsReferences < ActiveRecord::Migration[5.2]
  def change
    add_reference(:order_items, :products_variation, foreign_key: true)
  end
end
