class AddModeratorToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :moderator, :boolean, default: false
  end
end
