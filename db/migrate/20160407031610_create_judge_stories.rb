class CreateJudgeStories < ActiveRecord::Migration
  def change
    create_table :judge_stories do |t|
      t.integer :story_id
      t.integer :judge_id
      t.timestamps null: false
    end

    add_index :judge_stories, :story_id
    add_index :judge_stories, :judge_id
    add_index :judge_stories, [:story_id, :judge_id]
  end
end
