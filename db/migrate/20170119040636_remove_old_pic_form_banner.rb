class RemoveOldPicFormBanner < ActiveRecord::Migration
  def up
    remove_column :banners, :pic_l
    remove_column :banners, :pic_m
    remove_column :banners, :pic_s
  end

  def down
    add_column :banners, :pic_l, :string
    add_column :banners, :pic_m, :string
    add_column :banners, :pic_s, :string
  end
end
