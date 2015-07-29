class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.integer :profile_id
      t.string :award_type
      t.string :unit
      t.text :content
      t.date :publish_at
      t.text :source
      t.string :source_link
      t.text :origin_desc
      t.text :memo
      t.timestamps
    end
    add_index :awards, :profile_id
  end
end
