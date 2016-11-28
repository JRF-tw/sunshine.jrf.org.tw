class CreateValidScores < ActiveRecord::Migration
  def change
    create_table :valid_scores do |t|
      t.integer :story_id
      t.integer :judge_id
      t.integer :schedule_id
      t.integer :score_id
      t.string  :score_type
      t.integer :score_rater_id
      t.string  :score_rater_type
      t.hstore  :attitude_scores
      t.hstore  :command_scores
      t.hstore  :quality_scores
      t.timestamps null: false
    end
    add_index :valid_scores, :story_id
    add_index :valid_scores, :judge_id
    add_index :valid_scores, :schedule_id
    add_index :valid_scores, [:score_id, :score_type]
    add_index :valid_scores, [:score_rater_id, :score_rater_type]
  end
end
