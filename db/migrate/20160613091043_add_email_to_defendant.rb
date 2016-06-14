class AddEmailToDefendant < ActiveRecord::Migration
  def change
    add_column :defendants, :email, :string
    add_column :defendants, :unconfirmed_email, :string
    add_column :defendants, :confirmed_at, :datetime
    add_column :defendants, :confirmation_token, :string
    add_column :defendants, :confirmation_sent_at, :datetime

    add_index :defendants, :email,                unique: true
    add_index :defendants, :confirmation_token,   unique: true

  end
end
