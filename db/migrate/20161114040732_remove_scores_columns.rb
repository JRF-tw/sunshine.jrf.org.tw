class RemoveScoresColumns < ActiveRecord::Migration
  def up
    remove_column :schedule_scores, :rating_score
    remove_column :schedule_scores, :command_score
    remove_column :schedule_scores, :attitude_score
    remove_column :verdict_scores, :quality_score
    remove_column :verdict_scores, :rating_score
  end

  def down
    add_column :schedule_scores, :rating_score, :float
    add_column :schedule_scores, :command_score, :float
    add_column :schedule_scores, :attitude_score, :float
    add_column :verdict_scores, :quality_score, :float
    add_column :verdict_scores, :rating_score, :float
  end
end
