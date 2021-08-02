require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
    test "a category can only have one parent" do
      parent = Category.create(name: "bedroom")
      Category.create(name: "pillows", subcategory_id: parent.id)
    end
end
