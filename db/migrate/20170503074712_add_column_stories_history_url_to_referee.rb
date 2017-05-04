class AddColumnStoriesHistoryUrlToReferee < ActiveRecord::Migration
  def up
    add_column :verdicts, :stories_history_url, :string
    add_column :rules, :stories_history_url, :string
  end

  def down
    remove_column :verdicts, :stories_history_url
    remove_column :rules, :stories_history_url
  end
end
