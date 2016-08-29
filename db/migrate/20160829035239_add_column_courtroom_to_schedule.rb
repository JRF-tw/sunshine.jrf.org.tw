class AddColumnCourtroomToSchedule < ActiveRecord::Migration
  def up
    add_column :schedules, :courtroom, :string
    add_column :schedules, :start_at, :datetime
    rename_column :schedules, :date, :start_on

    add_index :schedules, :courtroom
  end

  def down
    remove_column :schedules, :courtroom, :string
    rename_column :schedules, :start_on, :date 
  end
end
