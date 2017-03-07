class AddColumnCalculatedScoreToStory < ActiveRecord::Migration
  def up
    add_column :stories, :is_calculated, :boolean, default: false
    add_index :stories, :is_calculated
  end

  def down
    remove_column :stories, :is_calculated
  end
end
