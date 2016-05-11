class AddColumnScrapNameToCourts < ActiveRecord::Migration
  def change
    add_column :courts, :scrap_name, :string
    add_index :courts, :scrap_name
  end
end
