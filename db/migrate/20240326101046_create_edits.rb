class CreateEdits < ActiveRecord::Migration[7.2]
  def change
    create_table :edits do |t|
      t.references :leaf, null: false, foreign_key: true
      t.references :leafable, polymorphic: true, null: false
      t.string :action, null: false

      t.timestamps
    end
  end
end
