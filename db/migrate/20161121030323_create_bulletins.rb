class CreateBulletins < ActiveRecord::Migration
  def change
    create_table :bulletins do |t|
      t.string :title
      t.text :content
      t.text :pic
      t.boolean :is_hidden
      t.timestamps null: false
    end

    add_index :bulletins, :is_hidden
    add_index :bulletins, :title
    add_index :bulletins, :content
  end
end
