require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
    test "a category can only have one parent" do
      parent = Category.create(name: "bedroom")
      child = Category.create(name: "pillows", subcategory_id: parent.id)
      assert child.subcategory_id == parent.id
      assert Category.where(subcategory_id: parent.id).size == 1
    end
end
