require "test_helper"

class Public::LeavesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:handbook)
    @book.update! published: true
  end

  test "show public page" do
    get public_leaf_url(@book.slug, leaves(:welcome_page).to_param)
    assert_response :success
  end

  test "show public section" do
    get public_leaf_url(@book.slug, leaves(:welcome_section).to_param)
    assert_response :success
  end

  test "show public picture" do
    get public_leaf_url(@book.slug, leaves(:reading_picture).to_param)
    assert_response :success
  end
end
