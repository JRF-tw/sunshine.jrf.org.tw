class CreateSuits < ActiveRecord::Migration
  def change
    create_table :suits do |t|
      t.string :title
      t.text :summary
      t.text :content
      t.string :state
      t.string :pic
      t.integer :suit_no
      t.string :keyword
      t.timestamps
    end
  end
end
