class AddColumnPublishedDateToVerdicts < ActiveRecord::Migration
  def change
    add_column :verdicts, :publish_date, :date
    add_index :verdicts, :publish_date
  end
end
