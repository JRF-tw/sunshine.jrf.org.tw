class AddColumnUnconfirmPhoneToDefendants < ActiveRecord::Migration
  def change
    add_column :defendants, :unconfirmed_phone, :string
  end
end
