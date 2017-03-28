class RenameColumnToVerdictAndRule < ActiveRecord::Migration
  def up
    rename_column :verdicts, :summary, :reason
    rename_column :verdicts, :publish_on, :published_on
    rename_column :rules, :summary, :reason
    rename_column :rules, :publish_on, :published_on
    add_column :verdicts, :related_stories, :text
    add_column :rules, :related_stories, :text
  end

  def down
    rename_column :verdicts, :reason, :summary
    rename_column :verdicts, :published_on, :publish_on
    rename_column :rules, :reason, :summary
    rename_column :rules, :published_on, :publish_on
    remove_column :verdicts, :related_stories
    remove_column :rules, :related_stories
  end
end
