class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer   :court_id
      t.integer   :main_judge_id
      t.string    :type
      t.integer   :year
      t.string    :word_type
      t.integer   :number
      t.timestamps null: false
    end

    add_index :stories, :court_id
    add_index :stories, :main_judge_id
  end
end
