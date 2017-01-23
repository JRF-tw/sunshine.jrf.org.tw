class AddColumnContentToVerdict < ActiveRecord::Migration
  def up
    add_column :verdicts, :content, :string
  end

  def down
    remove_column :verdicts, :content
  end
end
