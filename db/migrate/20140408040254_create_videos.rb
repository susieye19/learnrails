class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :category
      t.text :notes
      t.text :transcript
      t.string :url

      t.timestamps
    end
  end
end
