class AddColumnSummaryVerdictAndRule < ActiveRecord::Migration
  
  def up
    add_column :verdicts, :summary, :string
    add_column :rules, :summary, :string

    add_index :verdicts, :summary
    add_index :rules, :summary
  end

  def down
    remove_column :verdicts, :summary
    remove_column :rules, :summary
  end
end
