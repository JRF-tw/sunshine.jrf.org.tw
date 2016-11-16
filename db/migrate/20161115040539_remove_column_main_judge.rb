class RemoveColumnMainJudge < ActiveRecord::Migration
  def up
    remove_column :stories, :main_judge_id
    remove_column :verdicts, :main_judge_id
    remove_column :verdicts, :main_judge_name
  end

  def down
    add_column :stories, :main_judge_id, :integer
    add_column :verdicts, :main_judge_id, :integer
    add_column :verdicts, :main_judge_name, :string
  end
end
