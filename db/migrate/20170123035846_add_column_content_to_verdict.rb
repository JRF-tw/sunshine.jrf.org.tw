class AddColumnContentToVerdict < ActiveRecord::Migration
  def up
    add_column :verdicts, :content_file, :string
  end

  def down
    remove_column :verdicts, :content_file
  end
end
