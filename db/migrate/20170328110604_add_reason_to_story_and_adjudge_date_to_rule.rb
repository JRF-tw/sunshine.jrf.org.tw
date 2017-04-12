class AddReasonToStoryAndAdjudgeDateToRule < ActiveRecord::Migration
  def up
    add_column :stories, :reason, :string
    rename_column :stories, :adjudge_date, :adjudged_on
    rename_column :stories, :pronounce_date, :pronounced_on 
    add_column :rules, :adjudged_on, :date
    rename_column :verdicts, :adjudge_date, :adjudged_on

    add_index :stories, :reason
    add_index :rules, :adjudged_on
  end

  def down
    remove_column :stories, :reason, :string
    rename_column :stories, :adjudged_on, :adjudge_date
    rename_column :stories, :pronounced_on, :pronounce_date 
    remove_column :rules, :adjudged_on, :date
    rename_column :verdicts, :adjudged_on, :adjudge_date
  end
end
