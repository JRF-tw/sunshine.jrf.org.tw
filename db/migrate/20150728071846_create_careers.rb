class CreateCareers < ActiveRecord::Migration
  def change
    create_table :careers do |t|
      t.integer :profile_id
      t.string :career_type
      t.string :old_unit
      t.string :old_title
      t.string :old_assign_court
      t.string :old_assign_judicial
      t.string :old_pt
      t.string :new_unit
      t.string :new_title
      t.string :new_assign_court
      t.string :new_assign_judicial
      t.string :new_pt
      t.date :start_at
      t.date :end_at
      t.date :publish_at
      t.text :source
      t.string :source_link
      t.text :origin_desc
      t.text :memo
      t.timestamps
    end
    add_index :careers, :profile_id
  end
end
