class AddColumnCodeToCourts < ActiveRecord::Migration
  def change
    add_column :courts, :code, :string
    add_index :courts, :code
  end
end
