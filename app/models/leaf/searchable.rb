module Leaf::Searchable
  extend ActiveSupport::Concern

  included do
    after_create_commit  :create_in_search_index,   if: :searchable?
    after_update_commit  :update_in_search_index,   if: :searchable?
    after_destroy_commit :remove_from_search_index, if: :searchable?

    scope :search, ->(query) {
      joins("join leaf_search_index on leaves.id = leaf_search_index.rowid")
        .where("leaf_search_index = ?", query)
    }

    scope :highlight_matches, ->(query) {
      search(query).select(
        "leaves.*",
        "highlight(leaf_search_index, 0, '<mark>', '</mark>') as title_match",
        "snippet(leaf_search_index, 1, '<mark>', '</mark>', '...', 20) as content_match")
    }
  end

  class_methods do
    def reindex_all
      all.map &:reindex
    end
  end

  def reindex
    update_in_search_index if searchable?
  end

  private
    def searchable?
      searchable_content.present?
    end

    def create_in_search_index
      execute_sql_with_binds "insert into leaf_search_index(rowid, title, content) values (?, ?, ?)",
        id, title, searchable_content
    end

    def update_in_search_index
      transaction do
        updated = execute_sql_with_binds "update leaf_search_index set title = ?, content = ? where rowid = ?",
          title, searchable_content, id

        create_in_search_index unless updated
      end
    end

    def remove_from_search_index
      execute_sql_with_binds "delete from leaf_search_index where rowid = ?", id
    end

    def execute_sql_with_binds(*statement)
      self.class.connection.execute self.class.sanitize_sql(statement)

      self.class.connection.raw_connection.changes.nonzero?
    end
end
