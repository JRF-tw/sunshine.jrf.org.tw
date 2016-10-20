class CreateCrawlerHistories < ActiveRecord::Migration
  def change
    create_table :crawler_histories do |t|
      t.date      :scrap_at
      t.integer   :courts_count, default: 0, null: false
      t.integer   :branches_count, default: 0, null: false
      t.integer   :judges_count, default: 0, null: false
      t.integer   :verdicts_count, default: 0, null: false
      t.integer   :schedules_count, default: 0, null: false
      t.timestamps null: false
    end
    add_index :crawler_histories, :scrap_at
  end
end
