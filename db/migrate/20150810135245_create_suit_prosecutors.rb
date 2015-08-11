class CreateSuitProsecutors < ActiveRecord::Migration
  def change
    create_table :suit_prosecutors do |t|
      t.integer :suit_id
      t.integer :profile_id
      t.timestamps
    end
    add_index :suit_prosecutors, :profile_id
    add_index :suit_prosecutors, :suit_id
    add_index :suit_prosecutors, [:profile_id, :suit_id]
  end
end
