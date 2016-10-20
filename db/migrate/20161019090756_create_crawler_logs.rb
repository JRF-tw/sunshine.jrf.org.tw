class CreateCrawlerLogs < ActiveRecord::Migration
  def change
    create_table :crawler_logs do |t|
      t.integer   :crawler_history_id
      t.integer   :crawler_kind
      t.integer   :crawler_error_type
      t.text      :crawler_errors
      t.timestamps null: false
    end
    add_index :crawler_logs, :crawler_history_id
    add_index :crawler_logs, :crawler_kind
    add_index :crawler_logs, :crawler_error_type
    add_index :crawler_logs, [:crawler_kind, :crawler_error_type]
    add_index :crawler_logs, [:crawler_history_id, :crawler_kind, :crawler_error_type], name: 'crawler_full_index'
  end
end
