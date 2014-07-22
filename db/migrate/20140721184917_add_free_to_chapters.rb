class AddFreeToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :free, :boolean
  end
end
