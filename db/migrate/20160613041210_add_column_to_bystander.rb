class AddColumnToBystander < ActiveRecord::Migration
  def change
    add_column :bystanders, :phone_number, :string
    add_column :bystanders, :school, :string
    add_column :bystanders, :student_number, :string
    add_column :bystanders, :department_level, :string

    add_index :bystanders, :school
  end
end
