class CreateScheduleScores < ActiveRecord::Migration
  def change
    create_table :schedule_scores do |t|
      t.integer  :schedule_id
      t.integer  :judge_id
      t.integer  :schedule_rater_id
      t.string    :schedule_rater_type
      t.integer  :rating_score
      t.integer  :command_score
      t.integer  :attitude_score
      t.hstore    :data
      t.boolean   :appeal_judge, default: false
      t.timestamps null: false
    end

    add_index :schedule_scores, :schedule_id
    add_index :schedule_scores, :judge_id
    add_index :schedule_scores, :appeal_judge
    add_index :schedule_scores, [:judge_id, :schedule_rater_id]
  end
end
