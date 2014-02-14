class AddChapterIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :chapter_id, :integer
  end
end
