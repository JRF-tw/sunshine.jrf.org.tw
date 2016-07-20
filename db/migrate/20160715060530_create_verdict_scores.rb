class CreateVerdictScores < ActiveRecord::Migration
  def change
    create_table :verdict_scores do |t|
      t.integer :story_id
      t.integer :judge_id
      t.integer :verdict_rater_id
      t.string  :verdict_rater_type
      t.integer :quality_score
      t.integer :rating_score
      t.hstore  :data
      t.boolean :appeal_judge
      t.integer :status
      t.timestamps null: false
    end

    add_index :verdict_scores, :story_id
    add_index :verdict_scores, :judge_id
    add_index :verdict_scores, [:verdict_rater_id, :verdict_rater_type]
    add_index :verdict_scores, :appeal_judge
    add_index :verdict_scores, :status
  end
end
