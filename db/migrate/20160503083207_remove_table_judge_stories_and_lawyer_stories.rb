class RemoveTableJudgeStoriesAndLawyerStories < ActiveRecord::Migration
  def up
    drop_table :judge_stories
    drop_table :lawyer_stories
  end

  def down
    create_table :judge_stories do |t|
      t.integer :story_id
      t.integer :judge_id
      t.timestamps null: false
    end

    add_index :judge_stories, :story_id
    add_index :judge_stories, :judge_id
    add_index :judge_stories, [:story_id, :judge_id]

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
