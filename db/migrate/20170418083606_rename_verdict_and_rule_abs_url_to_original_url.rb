class RenameVerdictAndRuleAbsUrlToOriginalUrl < ActiveRecord::Migration
  def up
    rename_column :verdicts, :abs_url, :original_url
    rename_column :rules, :abs_url, :original_url
  end

  def down
    rename_column :verdicts, :original_url, :abs_url
    rename_column :rules, :original_url, :abs_url
  end
end
