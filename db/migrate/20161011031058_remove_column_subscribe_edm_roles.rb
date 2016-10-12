class RemoveColumnSubscribeEdmRoles < ActiveRecord::Migration
  def up
    remove_column :lawyers, :subscribe_edm
    remove_column :court_observers, :subscribe_edm
    remove_column :parties, :subscribe_edm
  end

  def down
    add_column :lawyers, :subscribe_edm, :boolean, default: false
    add_index :lawyers, :subscribe_edm
    add_column :court_observers, :subscribe_edm, :boolean, default: false
    add_index :court_observers, :subscribe_edm
    add_column :parties, :subscribe_edm, :boolean, default: false
    add_index :parties, :subscribe_edm
  end
end
