class AddFieldsToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :notes, :text
    add_column :chapters, :transcript, :text
  end
end
