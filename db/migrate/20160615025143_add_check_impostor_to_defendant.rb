class AddCheckImpostorToDefendant < ActiveRecord::Migration
  def change
    add_column :defendants, :imposter, :boolean, default: false
    add_column :defendants, :imposter_identify_number, :string

    add_index :defendants, :imposter
  end
end
