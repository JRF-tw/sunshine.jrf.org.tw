class CreateVerdictRelations < ActiveRecord::Migration
  def up
    create_table :verdict_relations do |t|
      t.integer :verdict_id
      t.integer :person_id
      t.string :person_type
      t.timestamps null: false
    end
    add_index :verdict_relations, :verdict_id
    add_index :verdict_relations, :person_id
    add_index :verdict_relations, :person_type
    add_index :verdict_relations, [:person_id, :person_type]
    add_index :verdict_relations, [:verdict_id, :person_type]
    add_index :verdict_relations, [:verdict_id, :person_id]
    add_index :verdict_relations, [:verdict_id, :person_id, :person_type], name: "verdict_relations_full_index"
  end

  def down
    drop_table :verdict_relations
  end
end
