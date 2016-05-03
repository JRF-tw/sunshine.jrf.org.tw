class CreateJudgeVerdicts < ActiveRecord::Migration
  def change
    create_table :judge_verdicts do |t|
      t.integer :verdict_id
      t.integer :judge_id
      t.timestamps null: false
    end

    add_index :judge_verdicts, :verdict_id
    add_index :judge_verdicts, :judge_id
    add_index :judge_verdicts, [:verdict_id, :judge_id]
  end
end
