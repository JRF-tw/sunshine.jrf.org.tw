class RenameColumnStroyIdForScheduleScores < ActiveRecord::Migration
  def change
    rename_column :schedule_scores, :stroy_id, :story_id
  end
end
