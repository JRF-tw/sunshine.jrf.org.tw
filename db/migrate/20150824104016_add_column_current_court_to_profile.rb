class AddColumnCurrentCourtToProfile < ActiveRecord::Migration
  def change
  	add_column :profiles, :current_court, :string
    add_index :profiles, :current_court
  end
end
