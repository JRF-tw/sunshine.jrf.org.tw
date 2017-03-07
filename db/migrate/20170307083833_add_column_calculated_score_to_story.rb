class AddColumnCalculatedScoreToStory < ActiveRecord::Migration
  def up
    add_column :stories, :calculated_score, :boolean, default: false
    add_index :stories, :calculated_score
  end

  def down
    remove_column :stories, :calculated_score
  end
end
