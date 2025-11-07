require "application_system_test_case"

class BreedsTest < ApplicationSystemTestCase
  setup do
    @breed = breeds(:one)
  end

  test "visiting the index" do
    visit breeds_url
    assert_selector "h1", text: "Breeds"
  end

  test "should create breed" do
    visit breeds_url
    click_on "New breed"

    fill_in "Name", with: @breed.name
    click_on "Create Breed"

    assert_text "Breed was successfully created"
    click_on "Back"
  end

  test "should update Breed" do
    visit breed_url(@breed)
    click_on "Edit this breed", match: :first

    fill_in "Name", with: @breed.name
    click_on "Update Breed"

    assert_text "Breed was successfully updated"
    click_on "Back"
  end

  test "should destroy Breed" do
    visit breed_url(@breed)
    click_on "Destroy this breed", match: :first

    assert_text "Breed was successfully destroyed"
  end
end
