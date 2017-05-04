class CreateRuleRelations < ActiveRecord::Migration
  def change
    create_table :rule_relations do |t|
      t.integer :rule_id
      t.integer :person_id
      t.string  :person_type
      t.timestamps null: false
    end

    add_index :rule_relations, :rule_id
    add_index :rule_relations, :person_id
    add_index :rule_relations, :person_type
    add_index :rule_relations, [:person_id, :person_type]
    add_index :rule_relations, [:rule_id, :person_type]
    add_index :rule_relations, [:rule_id, :person_id]
    add_index :rule_relations, [:rule_id, :person_id, :person_type], name: "rule_relations_full_index"
  end
end
