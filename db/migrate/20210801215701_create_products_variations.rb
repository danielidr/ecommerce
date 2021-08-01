class CreateProductsVariations < ActiveRecord::Migration[5.2]
  def change
    create_table :products_variations do |t|
      t.references :product, foreign_key: true
      t.references :variation, foreign_key: true
      t.integer :stock

      t.timestamps
    end
  end
end
