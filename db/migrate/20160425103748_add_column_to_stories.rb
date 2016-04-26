class AddColumnToStories < ActiveRecord::Migration
  def change
    add_column  :stories, :defendant_names, :text
    add_column  :stories, :lawyer_names, :text
    add_column  :stories, :judges_names, :text
    add_column  :stories, :prosecutor_names, :text
  end
end
