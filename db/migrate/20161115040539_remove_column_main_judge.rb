class RemoveColumnMainJudge < ActiveRecord::Migration
  def change
    remove_column :stories, :main_judge_id
    remove_column :verdicts, :main_judge_id
    remove_column :verdicts, :main_judge_name
  end
end
