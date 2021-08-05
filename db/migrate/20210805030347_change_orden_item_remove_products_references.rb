class ChangeOrdenItemRemoveProductsReferences < ActiveRecord::Migration[5.2]
  def change
    remove_reference(:order_items, :product, foreign_key: false)
  end
end
