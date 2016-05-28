class AddColumnMainJudgeIdToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :branch_judge_id, :integer
    add_index :schedules, :branch_judge_id
    add_index :schedules, [ :branch_judge_id, :story_id]
    add_index :schedules, [ :branch_judge_id, :court_id]
    add_index :schedules, [ :branch_judge_id, :court_id, :story_id]
  end
end
