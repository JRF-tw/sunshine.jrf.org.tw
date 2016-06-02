class AddDeviseColumnToLawyer < ActiveRecord::Migration
  def change
    change_column :lawyers, :name, :string, null: false

    add_column :lawyers, :email, :string, null: false
    add_column :lawyers, :encrypted_password, :string, default: ""
    add_column :lawyers, :reset_password_token, :string
    add_column :lawyers, :reset_password_sent_at, :datetime
    add_column :lawyers, :remember_created_at, :datetime
    add_column :lawyers, :sign_in_count, :integer, default: 0, null: false
    add_column :lawyers, :last_sign_in_at, :datetime
    add_column :lawyers, :current_sign_in_at, :datetime
    add_column :lawyers, :current_sign_in_ip, :string
    add_column :lawyers, :last_sign_in_ip, :string
    add_column :lawyers, :confirmation_token, :string
    add_column :lawyers, :confirmation_sent_at, :datetime
    add_column :lawyers, :confirmed_at, :datetime
    add_column :lawyers, :unconfirmed_email, :string

    add_index :lawyers, :email,                unique: true
    add_index :lawyers, :reset_password_token, unique: true
    add_index :lawyers, :confirmation_token,   unique: true

  end
end
