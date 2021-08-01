require "application_system_test_case"

class VariationsTest < ApplicationSystemTestCase
  setup do
    @variation = variations(:one)
  end

  test "visiting the index" do
    visit variations_url
    assert_selector "h1", text: "Variations"
  end

  test "creating a Variation" do
    visit variations_url
    click_on "New Variation"

    fill_in "Color", with: @variation.color
    fill_in "Size", with: @variation.size
    click_on "Create Variation"

    assert_text "Variation was successfully created"
    click_on "Back"
  end

  test "updating a Variation" do
    visit variations_url
    click_on "Edit", match: :first

    fill_in "Color", with: @variation.color
    fill_in "Size", with: @variation.size
    click_on "Update Variation"

    assert_text "Variation was successfully updated"
    click_on "Back"
  end

  test "destroying a Variation" do
    visit variations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Variation was successfully destroyed"
  end
end
