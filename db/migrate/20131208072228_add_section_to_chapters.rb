class AddSectionToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :section, :string
  end
end
