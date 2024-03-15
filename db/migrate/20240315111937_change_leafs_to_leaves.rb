class ChangeLeafsToLeaves < ActiveRecord::Migration[7.2]
  def change
    rename_table :leafs, :leaves
  end
end
