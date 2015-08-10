class CreateJudgmentProsecutors < ActiveRecord::Migration
  def change
    create_table :judgment_prosecutors do |t|
      t.integer :profile_id
      t.integer :judgment_id
      t.timestamps
    end
    add_index :judgment_prosecutors, :profile_id
    add_index :judgment_prosecutors, :judgment_id
    add_index :judgment_prosecutors, [:profile_id, :judgment_id]
  end
end
