class AddColumnFileToVardicts < ActiveRecord::Migration
  def change
    add_column  :verdicts, :file, :string
    add_column  :verdicts, :defendant_names, :text
    add_column  :verdicts, :lawyer_names, :text
    add_column  :verdicts, :judges_names, :text
    add_column  :verdicts, :prosecutor_names, :text
    add_column  :verdicts, :is_judgment, :boolean
    add_index   :verdicts, :is_judgment
  end
end
