class AddColumnStatusToPunishments < ActiveRecord::Migration
  def change
    add_column :punishments, :status, :text
  end
end
