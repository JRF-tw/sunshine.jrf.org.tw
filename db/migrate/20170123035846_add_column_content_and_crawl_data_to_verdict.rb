class AddColumnContentAndCrawlDataToVerdict < ActiveRecord::Migration
  def up
    add_column :verdicts, :content_file, :string
    add_column :verdicts, :crawl_data, :hstore
  end

  def down
    remove_column :verdicts, :content_file
    remove_column :verdicts, :crawl_data
  end
end
