class AddColumnIsAdjudgeToStories < ActiveRecord::Migration
  def change
    add_column :stories, :is_adjudge, :boolean, default: false
    add_index :stories, :is_adjudge
  end
end
