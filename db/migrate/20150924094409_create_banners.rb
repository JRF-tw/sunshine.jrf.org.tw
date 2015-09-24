class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :pic_l
      t.string :pic_m
      t.string :pic_s
      t.integer :weight
      t.boolean :is_hidden
      t.timestamps
    end
  end
end
