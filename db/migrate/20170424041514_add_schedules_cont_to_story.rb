class AddSchedulesContToStory < ActiveRecord::Migration
  def change
    add_column :stories, :schedules_count, :integer, default: 0

    Story.find_each(batch_size: 2000) do |s|
      Story.reset_counters(s.id, :schedules)  
    end
  end
end
