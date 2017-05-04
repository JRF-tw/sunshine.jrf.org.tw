class AddSchedulesContToStory < ActiveRecord::Migration
  def up
    add_column :stories, :schedules_count, :integer, default: 0
  end

  def down
    remove_column :stories, :schedules_count
  end
end
