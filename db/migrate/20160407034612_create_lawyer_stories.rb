class CreateLawyerStories < ActiveRecord::Migration
  def change
    create_table :lawyer_stories do |t|
      t.integer :story_id
      t.integer :lawyer_id
      t.timestamps null: false
    end

    add_index :lawyer_stories, :story_id
    add_index :lawyer_stories, :lawyer_id
    add_index :lawyer_stories, [:story_id, :lawyer_id]
  end
end
