class AddColumnPhoneConfirmedAtToDefendant < ActiveRecord::Migration
  def change
    add_column :defendants, :phone_confirmed_at, :datetime
  end
end
