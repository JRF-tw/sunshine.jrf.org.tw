class AddColumnRolesDataToVerdict < ActiveRecord::Migration
  def up
    add_column :verdicts, :roles_data, :hstore
  end

  def down
    remove_column :verdicts, :roles_data
  end
end
