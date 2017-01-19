class AddDefaultValueToJudgeAndProsecutor < ActiveRecord::Migration
  def up
    change_column_default(:judges, :is_prosecutor, false)
    change_column_default(:prosecutors, :is_judge, false)
  end

  def down
    change_column_default(:judges, :is_prosecutor, nil)
    change_column_default(:prosecutors, :is_judge, nil)
  end
end
