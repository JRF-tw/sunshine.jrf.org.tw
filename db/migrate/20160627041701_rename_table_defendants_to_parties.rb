class RenameTableDefendantsToParties < ActiveRecord::Migration
  def up
    rename_table :defendants, :parties
    rename_column :stories, :defendant_names, :party_names
    rename_column :verdicts, :defendant_names, :party_names
  end

  def down
    rename_table :parties, :defendants
    rename_column :stories, :party_names, :defendant_names
    rename_column :verdicts, :party_names, :defendant_names
  end
end
