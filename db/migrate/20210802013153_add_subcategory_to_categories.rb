class AddSubcategoryToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :subcategory_id, :integer
  end
end
