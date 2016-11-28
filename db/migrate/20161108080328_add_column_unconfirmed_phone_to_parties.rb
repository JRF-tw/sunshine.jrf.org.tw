class AddColumnUnconfirmedPhoneToParties < ActiveRecord::Migration
  def up
    add_column :parties, :unconfirmed_phone, :string
    add_index :parties, :unconfirmed_phone
  end

  def down
    remove_column :parties, :unconfirmed_phone
  end
end
