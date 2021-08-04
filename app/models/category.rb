class Category < ApplicationRecord
  has_and_belongs_to_many :products

  has_many :subcategories, class_name: "Category", foreign_key: "subcategory_id", dependent: :destroy
  belongs_to :parent_category, class_name: "Category", foreign_key: "subcategory_id", optional: true

  def get_parent
    Category.find_by(id: subcategory_id)
  end

  def get_parents
    parent = get_parent()
    parents = [parent]
    if parent != nil
      p = parent.get_parent
      while p != nil
        parents.push(p)
        p = p.get_parent
      end
      return parents 
    end
    return []
  end

  def descendents
    subcategories.map do |subcategory|
      [subcategory] + subcategory.descendents
    end.flatten
  end

end
