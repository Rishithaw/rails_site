require "application_system_test_case"

class SubBreedsTest < ApplicationSystemTestCase
  setup do
    @sub_breed = sub_breeds(:one)
  end

  test "visiting the index" do
    visit sub_breeds_url
    assert_selector "h1", text: "Sub breeds"
  end

  test "should create sub breed" do
    visit sub_breeds_url
    click_on "New sub breed"

    fill_in "Breed", with: @sub_breed.breed_id
    fill_in "Name", with: @sub_breed.name
    click_on "Create Sub breed"

    assert_text "Sub breed was successfully created"
    click_on "Back"
  end

  test "should update Sub breed" do
    visit sub_breed_url(@sub_breed)
    click_on "Edit this sub breed", match: :first

    fill_in "Breed", with: @sub_breed.breed_id
    fill_in "Name", with: @sub_breed.name
    click_on "Update Sub breed"

    assert_text "Sub breed was successfully updated"
    click_on "Back"
  end

  test "should destroy Sub breed" do
    visit sub_breed_url(@sub_breed)
    click_on "Destroy this sub breed", match: :first

    assert_text "Sub breed was successfully destroyed"
  end
end
