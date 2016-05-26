class ChangeColumnDefendantPhoneNumber < ActiveRecord::Migration
  def up
    change_column :defendants, :phone_number, :string, null: true
  end

  def down
    change_column :defendants, :phone_number, :string, null: false
  end
end
