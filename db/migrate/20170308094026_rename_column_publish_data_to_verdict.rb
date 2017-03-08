class RenameColumnPublishDataToVerdict < ActiveRecord::Migration
  def change
    rename_column :verdicts, :publish_date, :publish_on
  end
end
