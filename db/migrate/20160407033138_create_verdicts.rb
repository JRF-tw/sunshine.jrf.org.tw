class CreateVerdicts < ActiveRecord::Migration
  def change
    create_table :verdicts do |t|
      t.integer :story_id
      t.text    :content
      t.timestamps null: false
    end
  end
end
