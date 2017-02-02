class AddColumnBeNoticedToLawyer < ActiveRecord::Migration
  def up
    add_column :lawyers, :be_noticed, :boolean, default: true
    add_index :lawyers, :be_noticed
  end

  def down
    remove_column :lawyers, :be_noticed 
  end
end
