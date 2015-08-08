class CreateJudgments < ActiveRecord::Migration
  def change
    create_table :judgments do |t|
      t.integer :court_id
      t.integer :main_judge_id
      t.integer :presiding_judge_id
      t.string :judge_no
      t.string :court_no
      t.string :judge_type
      t.date :judge_date
      t.text :reason
      t.text :content
      t.text :comment
      t.string :source
      t.string :source_link
      t.text :memo
      t.timestamps
    end
    add_index :judgments, :court_id
    add_index :judgments, :main_judge_id
    add_index :judgments, :judge_no
    add_index :judgments, :court_no
  end
end
