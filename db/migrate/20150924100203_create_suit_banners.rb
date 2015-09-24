class CreateSuitBanners < ActiveRecord::Migration
  def change
    create_table :suit_banners do |t|
      t.string :pic_l
      t.string :pic_m
      t.string :pic_s
      t.string :url
      t.string :alt_string
      t.string :title
      t.string :content
      t.integer :weight
      t.boolean :is_hidden
      t.timestamps
    end
  end
end
