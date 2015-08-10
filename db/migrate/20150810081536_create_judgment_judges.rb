class CreateJudgmentJudges < ActiveRecord::Migration
  def change
    create_table :judgment_judges do |t|
      t.integer :profile_id
      t.integer :judgment_id
      t.timestamps
    end
    add_index :judgment_judges, :profile_id
    add_index :judgment_judges, :judgment_id
    add_index :judgment_judges, [:profile_id, :judgment_id]
  end
end
