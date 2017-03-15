class ChangeColumnToVerdict < ActiveRecord::Migration
  def up
    rename_column :verdicts, :publish_date, :publish_on
    remove_column :verdicts, :is_judgment
  end

  def down
    rename_column :verdicts, :publish_on, :publish_date
    add_column :verdicts, :is_judgment, :boolean
    add_index :verdicts, :is_judgment
  end
end
