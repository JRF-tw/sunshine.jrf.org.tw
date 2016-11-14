class AddHstoreForScoredColumnToScore < ActiveRecord::Migration
  def change
    add_column :schedule_scores, :attitude_scores, :hstore
    add_column :schedule_scores, :command_scores, :hstore
    add_column :verdict_scores, :quality_scores, :hstore
  end
end
