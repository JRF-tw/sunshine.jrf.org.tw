class RemoveCourtTypeToCourt < ActiveRecord::Migration
  def up
    Court.where(court_type: '檢察署').destroy_all
    remove_column :courts, :court_type
  end

  def down
    add_column :courts, :court_type, :string
    add_index :courts, :court_type
  end
end
