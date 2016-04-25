class RemoveColumnContentForVerdicts < ActiveRecord::Migration
  def up
    remove_column :verdicts, :content
  end

  def down
    add_column :verdicts, :content, :text
  end
end
