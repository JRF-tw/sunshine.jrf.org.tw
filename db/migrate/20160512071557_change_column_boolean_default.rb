class ChangeColumnBooleanDefault < ActiveRecord::Migration
  def up
    change_column_default(:courts, :is_hidden, true)
    change_column_default(:judges, :is_active, true)
    change_column_default(:judges, :is_hidden, true)
    change_column_default(:verdicts, :is_judgment, false)
  end

  def down
    change_column_default(:courts, :is_hidden, nil)
    change_column_default(:judges, :is_active, nil)
    change_column_default(:judges, :is_hidden, nil)
    change_column_default(:verdicts, :is_judgment, nil)
  end
end
