class AddColumnActiveNoticeToLawyer < ActiveRecord::Migration
  def up
    add_column :lawyers, :active_notice, :boolean, default: true
    add_index :lawyers, :active_notice
  end

  def down
    remove_column :lawyers, :active_notice
  end
end
