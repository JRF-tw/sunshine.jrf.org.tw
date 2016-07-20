class AddColumnStoryIdToScheduleScores < ActiveRecord::Migration
  def change
    add_column :schedule_scores, :stroy_id, :integer
    add_index :schedule_scores, :stroy_id
  end
end
