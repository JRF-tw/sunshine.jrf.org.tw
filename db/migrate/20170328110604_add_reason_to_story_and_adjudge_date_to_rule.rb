class AddReasonToStoryAndAdjudgeDateToRule < ActiveRecord::Migration
  def up
    add_column :stories, :reason, :string
    add_column :rules, :adjudge_date, :date

    add_index :stories, :reason
    add_index :rules, :adjudge_date
  end

  def down
    remove_column :stories, :reason, :string
    remove_column :rules, :adjudge_date, :date
  end
end
