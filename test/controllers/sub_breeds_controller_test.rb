require "test_helper"

class SubBreedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sub_breed = sub_breeds(:one)
  end

  test "should get index" do
    get sub_breeds_url
    assert_response :success
  end

  test "should get new" do
    get new_sub_breed_url
    assert_response :success
  end

  test "should create sub_breed" do
    assert_difference("SubBreed.count") do
      post sub_breeds_url, params: { sub_breed: { breed_id: @sub_breed.breed_id, name: @sub_breed.name } }
    end

    assert_redirected_to sub_breed_url(SubBreed.last)
  end

  test "should show sub_breed" do
    get sub_breed_url(@sub_breed)
    assert_response :success
  end

  test "should get edit" do
    get edit_sub_breed_url(@sub_breed)
    assert_response :success
  end

  test "should update sub_breed" do
    patch sub_breed_url(@sub_breed), params: { sub_breed: { breed_id: @sub_breed.breed_id, name: @sub_breed.name } }
    assert_redirected_to sub_breed_url(@sub_breed)
  end

  test "should destroy sub_breed" do
    assert_difference("SubBreed.count", -1) do
      delete sub_breed_url(@sub_breed)
    end

    assert_redirected_to sub_breeds_url
  end
end
