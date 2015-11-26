class AddCurrentDepartmentAndBanchToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :current_department, :string
    add_column :profiles, :current_branch, :string
  end
end
