class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :profile_id
      t.date :publish_at
      t.string :name
      t.string :title
      t.text :content
      t.text :comment
      t.string :no
      t.string :source
      t.string :file
      t.text :memo
      t.timestamps
    end
    add_index :reviews, :profile_id
  end
end
