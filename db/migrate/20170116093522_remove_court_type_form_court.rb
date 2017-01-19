class RemoveCourtTypeFormCourt < ActiveRecord::Migration
  def up
    remove_column :courts, :court_type
  end

  def down
    add_column :courts, :court_type, :string
  end
end
