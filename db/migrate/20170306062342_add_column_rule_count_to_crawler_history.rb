class AddColumnRuleCountToCrawlerHistory < ActiveRecord::Migration
  def up
    add_column :crawler_histories, :rules_count, :integer,  default: 0, null: false
  end

  def down
    remove_column :crawler_histories, :rules_count
  end
end
