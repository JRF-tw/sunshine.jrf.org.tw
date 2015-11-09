class AddPunishmentsCountToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :punishments_count, :integer, default: 0
  end
end
