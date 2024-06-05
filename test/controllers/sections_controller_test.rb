require "test_helper"

class SectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in :kevin
  end

  test "create" do
    post book_sections_path(books(:handbook), format: :turbo_stream)
    assert_response :success

    new_section = Section.last
    assert_equal "Section", new_section.title
    assert_equal books(:handbook), new_section.leaf.book
  end
end
