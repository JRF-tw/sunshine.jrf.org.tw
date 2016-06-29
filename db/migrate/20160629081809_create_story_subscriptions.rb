class CreateStorySubscriptions < ActiveRecord::Migration
  def up
    create_table :story_subscriptions do |t|
      t.integer :story_id
      t.integer :subscriber_id
      t.string :subscriber_type
      t.timestamps null: false
    end
    add_index :story_subscriptions, :story_id
    add_index :story_subscriptions, :subscriber_id
    add_index :story_subscriptions, :subscriber_type
    add_index :story_subscriptions, [:subscriber_id, :subscriber_type]
    add_index :story_subscriptions, [:story_id, :subscriber_type]
    add_index :story_subscriptions, [:story_id, :subscriber_id]
    add_index :story_subscriptions, [:story_id, :subscriber_id, :subscriber_type], unique: true, name: "story_subscriptions_full_index"
  end

  def down
    drop_table :story_subscriptions
  end
end
