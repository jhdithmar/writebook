class AddAuthorToBooks < ActiveRecord::Migration[7.2]
  def change
    change_table :books do |t|
      t.string :author
    end
  end
end
