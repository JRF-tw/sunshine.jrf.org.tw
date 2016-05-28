class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :story_id
      t.integer :court_id
      t.integer :branch_name
      t.date    :date
      t.timestamps null: false
    end

    add_index :schedules, :story_id
    add_index :schedules, :court_id
    add_index :schedules, [:story_id, :court_id]
    add_index :schedules, [:date]
  end
end
