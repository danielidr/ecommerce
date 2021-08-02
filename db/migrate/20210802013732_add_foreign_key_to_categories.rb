class AddForeignKeyToCategories < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :categories, :categories, column: :subcategory_id 
  end
end
