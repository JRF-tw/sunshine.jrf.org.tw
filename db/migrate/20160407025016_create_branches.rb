class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.integer :court_id
      t.integer :judge_id
      t.string :name
      t.string :chamber_name
      t.timestamps null: false
    end

    add_index :branches, :court_id
    add_index :branches, :judge_id
    add_index :branches, [:court_id, :judge_id]
  end
end
