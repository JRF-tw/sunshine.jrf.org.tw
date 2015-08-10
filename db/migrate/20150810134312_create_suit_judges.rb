class CreateSuitJudges < ActiveRecord::Migration
  def change
    create_table :suit_judges do |t|
      t.integer :suit_id
      t.integer :profile_id
      t.timestamps
    end
    add_index :suit_judges, :profile_id
    add_index :suit_judges, :suit_id
    add_index :suit_judges, [:profile_id, :suit_id]
  end
end
