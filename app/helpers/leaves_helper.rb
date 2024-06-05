module LeavesHelper
  def leaf_item_tag(leaf, **, &)
    tag.li class: "arrangement__item toc__leaf toc__leaf--#{leaf.leafable_name}",
      id: dom_id(leaf),
      data: {
        id: leaf.id,
        arrangement_target: "item"
      }, **, &
  end

  def leaf_nav_tag(leaf, **, &)
    tag.nav data: {
      controller: "reading-tracker",
      reading_tracker_book_id_value: leaf.book_id,
      reading_tracker_leaf_id_value: leaf.id
    }, **, &
  end
end
