class CreateStoryRelations < ActiveRecord::Migration
  def change
    create_table :story_relations do |t|
      t.integer :story_id
      t.integer :people_id
      t.integer :people_type
      t.timestamps null: false
    end
    add_index :story_relations, :story_id
    add_index :story_relations, :people_id
    add_index :story_relations, :people_type
    add_index :story_relations, [:people_id, :people_type]
    add_index :story_relations, [:story_id, :people_type]
    add_index :story_relations, [:story_id, :people_id]
    add_index :story_relations, [:story_id, :people_id, :people_type]
  end
end
