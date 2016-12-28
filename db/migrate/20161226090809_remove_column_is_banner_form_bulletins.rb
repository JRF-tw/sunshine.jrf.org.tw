class RemoveColumnIsBannerFormBulletins < ActiveRecord::Migration
  def up
    remove_column :bulletins, :is_banner
  end

  def down
    add_column :bulletins, :is_banner, :bollean
  end
end
