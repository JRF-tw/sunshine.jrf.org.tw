class AddColumnMissedToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :missed, :boolean, default: false
    add_index :branches, [:missed, :court_id]
    add_index :branches, [:missed, :judge_id]
    add_index :branches, [:missed, :judge_id, :court_id]
    add_index :branches, :name
    add_index :branches, :chamber_name
    add_index :branches, :missed
  end
end
