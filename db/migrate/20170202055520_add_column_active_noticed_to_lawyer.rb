class AddColumnActiveNoticedToLawyer < ActiveRecord::Migration
  def up
    add_column :lawyers, :active_noticed, :boolean, default: true
    add_index :lawyers, :active_noticed
  end

  def down
    remove_column :lawyers, :active_noticed 
  end
end
