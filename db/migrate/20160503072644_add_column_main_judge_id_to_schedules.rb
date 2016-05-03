class AddColumnMainJudgeIdToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :main_judge_id, :integer
    add_index :schedules, :main_judge_id
    add_index :schedules, [ :main_judge_id, :story_id]
    add_index :schedules, [ :main_judge_id, :court_id]
    add_index :schedules, [ :main_judge_id, :court_id, :story_id]
  end
end
