class AddUrlToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :url, :string
  end
end
