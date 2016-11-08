class AddColumnUnconfirmedPhoneToParties < ActiveRecord::Migration
  def change
    add_column :parties, :unconfirmed_phone, :string
    add_index :parties, :unconfirmed_phone
  end
end
