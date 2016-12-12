class CreateBulletins < ActiveRecord::Migration
  def change
    create_table :bulletins do |t|
      t.string :title
      t.text :content
      t.text :pic
      t.boolean :is_banner, default: false
      t.timestamps null: false
    end

    add_index :bulletins, :is_banner
    add_index :bulletins, :title
  end
end
