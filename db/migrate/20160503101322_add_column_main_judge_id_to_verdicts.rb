class AddColumnMainJudgeIdToVerdicts < ActiveRecord::Migration
  def change
    add_column :verdicts, :main_judge_id, :integer
    add_index :verdicts, :main_judge_id
    add_index :verdicts, [:main_judge_id, :story_id]
  end
end
