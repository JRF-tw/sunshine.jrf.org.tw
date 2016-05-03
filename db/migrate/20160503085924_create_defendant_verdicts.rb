class CreateDefendantVerdicts < ActiveRecord::Migration
  def change
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
