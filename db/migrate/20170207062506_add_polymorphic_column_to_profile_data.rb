class AddPolymorphicColumnToProfileData < ActiveRecord::Migration
  def up
    add_column :educations, :owner_id, :integer
    add_column :educations, :owner_type, :string
    add_column :careers, :owner_id, :integer
    add_column :careers, :owner_type, :string
    add_column :licenses, :owner_id, :integer
    add_column :licenses, :owner_type, :string
    add_column :awards, :owner_id, :integer
    add_column :awards, :owner_type, :string
    add_column :punishments, :owner_id, :integer
    add_column :punishments, :owner_type, :string
    add_column :reviews, :owner_id, :integer
    add_column :reviews, :owner_type, :string
    add_column :articles, :owner_id, :integer
    add_column :articles, :owner_type, :string

    add_index :educations, [:owner_id, :owner_type]
    add_index :careers, [:owner_id, :owner_type]
    add_index :licenses, [:owner_id, :owner_type]
    add_index :awards, [:owner_id, :owner_type]
    add_index :punishments, [:owner_id, :owner_type]
    add_index :reviews, [:owner_id, :owner_type]
    add_index :articles, [:owner_id, :owner_type]
  end

  def down
    remove_column :educations, :owner_id
    remove_column :educations, :owner_type
    remove_column :careers, :owner_id
    remove_column :careers, :owner_type
    remove_column :licenses, :owner_id
    remove_column :licenses, :owner_type
    remove_column :awards, :owner_id
    remove_column :awards, :owner_type
    remove_column :punishments, :owner_id
    remove_column :punishments, :owner_type
    remove_column :reviews, :owner_id
    remove_column :reviews, :owner_type
    remove_column :articles, :owner_id
    remove_column :articles, :owner_type
  end
end
