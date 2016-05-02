class AddColumnToStoriesAndVerdicts < ActiveRecord::Migration
  def change
    add_column  :stories, :adjudge_date, :date
    add_column  :verdicts, :adjudge_date, :date
  end
end
