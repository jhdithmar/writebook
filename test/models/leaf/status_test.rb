require "test_helper"

class Leaf::StatusTest < ActiveSupport::TestCase
  test "trashed items are excluded by default" do
    assert_changes -> { books(:handbook).leaves.count }, from: 4, to: 3 do
      leaves(:summary_page).trashed!
    end
  end

  test "trashed items still exist" do
    assert_no_changes -> { books(:handbook).leaves.including_trashed.count } do
      leaves(:summary_page).trashed!
    end
  end
end
