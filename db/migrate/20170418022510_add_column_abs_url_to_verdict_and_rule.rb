class AddColumnAbsUrlToVerdictAndRule < ActiveRecord::Migration
  def up
    add_column :verdicts, :abs_url, :string
    add_column :rules, :abs_url, :string
  end

  def down
    remove_column :verdicts, :abs_url
    remove_column :rules, :abs_url
  end
end
