class RemoveVerdictMappingTable < ActiveRecord::Migration
  def up
    drop_table :judge_verdicts
    drop_table :lawyer_verdicts
    drop_table :defendant_verdicts
  end

  def down
    create_table :lawyer_verdicts do |t|
      t.integer :verdict_id
      t.integer :lawyer_id
      t.timestamps null: false
    end

    add_index :lawyer_verdicts, :verdict_id
    add_index :lawyer_verdicts, :lawyer_id
    add_index :lawyer_verdicts, [:verdict_id, :lawyer_id]

    create_table :judge_verdicts do |t|
      t.integer :verdict_id
      t.integer :judge_id
      t.timestamps null: false
    end

    add_index :judge_verdicts, :verdict_id
    add_index :judge_verdicts, :judge_id
    add_index :judge_verdicts, [:verdict_id, :judge_id]

    create_table :defendant_verdicts do |t|
      t.integer :verdict_id
      t.integer :defendant_id
      t.timestamps null: false
    end

    add_index :defendant_verdicts, :verdict_id
    add_index :defendant_verdicts, :defendant_id
    add_index :defendant_verdicts, [:verdict_id, :defendant_id]
  end
end
