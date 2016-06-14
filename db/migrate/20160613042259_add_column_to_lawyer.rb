class AddColumnToLawyer < ActiveRecord::Migration
  def change
    add_column :lawyers, :phone_number, :string
    add_column :lawyers, :office_number, :string
  end
end
