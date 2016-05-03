class CreateLawyerVerdicts < ActiveRecord::Migration
  def change
    create_table :lawyer_verdicts do |t|
      t.integer :verdict_id
      t.integer :lawyer_id
      t.timestamps null: false
    end

    add_index :lawyer_verdicts, :verdict_id
    add_index :lawyer_verdicts, :lawyer_id
    add_index :lawyer_verdicts, [:verdict_id, :lawyer_id]
  end
end
