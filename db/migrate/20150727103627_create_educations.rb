class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.integer :profile_id
      t.string :title
      t.text :content
      t.date :start_at
      t.date :end_at
      t.string :source
      t.text :memo
      t.timestamps
    end

    add_index :educations, :profile_id
  end
end
