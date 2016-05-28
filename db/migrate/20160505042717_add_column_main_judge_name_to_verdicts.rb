class AddColumnMainJudgeNameToVerdicts < ActiveRecord::Migration
  def change
    add_column :verdicts, :main_judge_name, :string
  end
end
