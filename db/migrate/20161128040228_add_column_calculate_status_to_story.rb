class AddColumnCalculateStatusToStory < ActiveRecord::Migration
  def up
    add_column :stories, :calculate_status, :integer, default: 1
    add_index :stories, :calculate_status
  end

  def down
    remove_column :stories, :calculate_status
  end
end
