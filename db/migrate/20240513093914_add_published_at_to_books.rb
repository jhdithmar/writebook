class AddPublishedAtToBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :published_at, :datetime
    add_index :books, :published_at
  end
end
