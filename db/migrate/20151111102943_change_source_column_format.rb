class ChangeSourceColumnFormat < ActiveRecord::Migration
  def change
    change_column :educations, :source, :text
    change_column :articles, :source, :text
    change_column :awards, :source_link, :text
    change_column :careers, :source_link, :text
    change_column :judgments, :source, :text
    change_column :judgments, :source_link, :text
    change_column :licenses, :source_link, :text
    change_column :procedures, :source_link, :text
    change_column :reviews, :source, :text
  end
end
