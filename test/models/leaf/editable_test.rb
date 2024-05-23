require "test_helper"

class Leaf::EditableTest < ActiveSupport::TestCase
  test "creating a leaf record the creation in an edit" do
    leaf = books(:handbook).press(Page.new(body: "New body"))

    assert leaf.edits.first.creation?
    assert_equal "New body", leaf.edits.first.page.body.content
  end

  test "editing a leafable records the edit" do
    leaves(:welcome_page).edit(body: "New body")

    assert_equal "New body", leaves(:welcome_page).page.body.content

    assert leaves(:welcome_page).edits.last.revision?
    assert_equal "New body", leaves(:welcome_page).edits.last.page.body.content
  end

  test "changes to the title don't record an edit" do
    assert_no_difference -> { leaves(:welcome_page).reload.edits.count } do
      leaves(:welcome_page).edit(title: "Welcome to The Handbook!")
    end
  end

  test "trashing a leaf records the edit" do
    leaves(:welcome_page).trashed!

    assert leaves(:welcome_page).trashed?

    assert leaves(:welcome_page).edits.last.trash?
    assert_equal "Welcome to The Handbook!", leaves(:welcome_page).edits.last.page.title
  end
end
