class RemoveChapterIdFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :chapter_id, :integer
  end
end
