class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :subject
      t.text :details
      t.integer :user_id

      t.timestamps
    end
  end
end
