class RemoveColumnUnconfirmedPhoneToDefendants < ActiveRecord::Migration
  def up
    remove_column :defendants, :unconfirmed_phone
  end

  def down
    add_column :defendants, :unconfirmed_phone, :string
  end
end
