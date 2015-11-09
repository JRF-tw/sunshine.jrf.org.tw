class UpdateCounterForProfile < ActiveRecord::Migration
  def change
    Admin::Profile.reset_column_information
    Admin::Profile.find_each do |profile|
      Admin::Profile.update_counters profile.id, punishments_count: profile.punishments.length
    end
  end
end
