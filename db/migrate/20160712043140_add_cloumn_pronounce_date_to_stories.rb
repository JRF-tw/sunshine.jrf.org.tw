class AddCloumnPronounceDateToStories < ActiveRecord::Migration
  def change
    add_column :stories, :pronounce_date, :date
    add_column :stories, :is_pronounce, :boolean, default: false
    add_index :stories, :pronounce_date
    add_index :stories, :is_pronounce
  end
end
