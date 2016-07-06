class RenameTableBystandersToCourtObservers < ActiveRecord::Migration
  def up
    rename_table :bystanders, :court_observers
  end

  def down
    rename_table :court_observers, :bystanders
  end
end
