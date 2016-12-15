class AddColumnIsProsecutorToJudge < ActiveRecord::Migration
  def up
    add_column :judges, :is_prosecutor, :boolean
    add_index :judges, :is_prosecutor
  end

  def down
    remove_column :judges, :is_prosecutor, :boolean
  end
end
