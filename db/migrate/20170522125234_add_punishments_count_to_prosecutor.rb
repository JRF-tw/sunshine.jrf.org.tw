class AddPunishmentsCountToProsecutor < ActiveRecord::Migration
  def change
    add_column :prosecutors, :punishments_count, :integer, default: 0
  end
end
