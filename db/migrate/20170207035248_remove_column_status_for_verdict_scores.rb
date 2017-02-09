class RemoveColumnStatusForVerdictScores < ActiveRecord::Migration
  def up
    remove_column :verdict_scores, :status
  end

  def down
    add_column :verdict_scores, :status, :integer
    add_index :verdict_scores, :status
  end
end
