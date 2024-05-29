class AddCaptionToPictures < ActiveRecord::Migration[7.2]
  def change
    add_column :pictures, :caption, :string
  end
end
