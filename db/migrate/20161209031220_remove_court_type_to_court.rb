class RemoveCourtTypeToCourt < ActiveRecord::Migration
  def up
    remove_column :courts, :court_type
  end

  def down
    add_column :courts, :court_type, :string
    add_index :courts, :court_type
  end
end
