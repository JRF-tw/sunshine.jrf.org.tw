class AddColumnIsHiddenToManyModel < ActiveRecord::Migration
  def change
    add_column :courts, :is_hidden, :boolean
    add_column :profiles, :is_hidden, :boolean
    add_column :educations, :is_hidden, :boolean
    add_column :careers, :is_hidden, :boolean
    add_column :licenses, :is_hidden, :boolean
    add_column :awards, :is_hidden, :boolean
    add_column :punishments, :is_hidden, :boolean
    add_column :reviews, :is_hidden, :boolean
    add_column :articles, :is_hidden, :boolean
    add_column :judgments, :is_hidden, :boolean
    add_column :suits, :is_hidden, :boolean
    add_column :procedures, :is_hidden, :boolean

    add_index :courts, :is_hidden
    add_index :profiles, :is_hidden
    add_index :educations, :is_hidden
    add_index :careers, :is_hidden
    add_index :licenses, :is_hidden
    add_index :awards, :is_hidden
    add_index :punishments, :is_hidden
    add_index :reviews, :is_hidden
    add_index :articles, :is_hidden
    add_index :judgments, :is_hidden
    add_index :suits, :is_hidden
    add_index :procedures, :is_hidden
    add_index :banners, :is_hidden
    add_index :suit_banners, :is_hidden
  end
end
