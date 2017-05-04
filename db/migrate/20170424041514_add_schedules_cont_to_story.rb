class AddSchedulesContToStory < ActiveRecord::Migration
  def up
    add_column :stories, :schedules_count, :integer, default: 0

    total = Story.all.size
    Story.find_each(batch_size: 2000).with_index do |s ,i|
      Story.reset_counters(s.id, :schedules)
      puts "#{i} / #{total}" if  i % 10000 == 0
    end
  end

  def down
    remove_column :stories, :schedules_count
  end
end
