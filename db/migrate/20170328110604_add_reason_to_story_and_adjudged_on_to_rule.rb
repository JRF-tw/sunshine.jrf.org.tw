class AddReasonToStoryAndAdjudgedOnToRule < ActiveRecord::Migration
  def up
    add_column :stories, :reason, :string
    add_column :rules, :adjudged_on, :date
    add_index :stories, :reason
    add_index :rules, :adjudged_on
  end

  def down
    remove_column :stories, :reason, :string
    remove_column :rules, :adjudged_on, :date
  end
end
