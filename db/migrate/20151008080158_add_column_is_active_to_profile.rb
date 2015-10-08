class AddColumnIsActiveToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :is_active, :boolean
    add_index :profiles, :is_active
  end
end
