class ChangeScoresColumnScoreToFloat < ActiveRecord::Migration
  def up
    change_column :schedule_scores, :rating_score, :float
    change_column :schedule_scores, :command_score, :float
    change_column :schedule_scores, :attitude_score, :float
    change_column :verdict_scores, :rating_score, :float
    change_column :verdict_scores, :quality_score, :float
  end

  def down
    change_column :schedule_scores, :rating_score, :integer
    change_column :schedule_scores, :command_score, :integer
    change_column :schedule_scores, :attitude_score, :integer
    change_column :verdict_scores, :rating_score, :integer
    change_column :verdict_scores, :quality_score, :integer
  end
end
