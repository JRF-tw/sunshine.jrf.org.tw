class ChangeScheduleColumnBranchName < ActiveRecord::Migration
  def change
    change_column :schedules, :branch_name, :string
  end
end
