class RenameColumnToStoriesAndVerdict < ActiveRecord::Migration
  def up
    rename_column :stories, :adjudge_date, :adjudged_on
    rename_column :stories, :pronounce_date, :pronounced_on 
    rename_column :stories, :is_adjudge, :is_adjudged
    rename_column :stories, :is_pronounce, :is_pronounced
    rename_column :verdicts, :adjudge_date, :adjudged_on
  end

  def down
    rename_column :stories, :adjudged_on, :adjudge_date
    rename_column :stories, :pronounced_on, :pronounce_date
    rename_column :stories, :is_adjudged, :is_adjudge
    rename_column :stories, :is_pronounced, :is_pronounce
    rename_column :verdicts, :adjudged_on, :adjudge_date
  end
end
