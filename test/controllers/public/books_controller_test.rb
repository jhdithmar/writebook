require "test_helper"

class Public::BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:handbook)
    @book.update! published: true
  end

  test "show public book" do
    get public_book_url(@book.slug)
    assert_response :success
  end
end
