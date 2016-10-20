class RenameColumnScrapAtToScrawlerOnForCrawlerHistories < ActiveRecord::Migration
  def change
    rename_column :crawler_histories, :scrap_at, :crawler_on
  end
end
