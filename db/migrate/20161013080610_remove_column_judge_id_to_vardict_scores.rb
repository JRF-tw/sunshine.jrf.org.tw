class RemoveColumnJudgeIdToVardictScores < ActiveRecord::Migration
  def up
    remove_column :verdict_scores, :judge_id
  end

  def down
    add_column :verdict_scores, :judge_id, :integer
    add_index :verdict_scores, :judge_id
  end
end
