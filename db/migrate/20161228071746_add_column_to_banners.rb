class AddColumnToBanners < ActiveRecord::Migration
  def up
    add_column :banners, :title, :string
    add_column :banners, :link, :string
    add_column :banners, :btn_wording, :string
    add_column :banners, :pic, :string
    add_column :banners, :desc, :string
  end

  def down
    remove_column :banners, :title, :string
    remove_column :banners, :link, :string
    remove_column :banners, :btn_wording, :string
    remove_column :banners, :pic, :string
    remove_column :banners, :desc, :string
  end
end
