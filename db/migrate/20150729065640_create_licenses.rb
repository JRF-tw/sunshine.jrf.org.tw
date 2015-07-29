class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.integer :profile_id
      t.string :license_type
      t.string :unit
      t.string :title
      t.date :publish_at
      t.text :source
      t.string :source_link
      t.text :origin_desc
      t.text :memo
      t.timestamps
    end
    add_index :licenses, :profile_id
  end
end
