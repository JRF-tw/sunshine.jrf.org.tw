class AddIndexToAdjudgeDate < ActiveRecord::Migration
  def change
    add_index :stories, :adjudge_date
    add_index :verdicts, :adjudge_date
  end
end
