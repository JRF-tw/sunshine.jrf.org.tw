class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.integer  :story_id
      t.string   :file
      t.text     :party_names
      t.text     :lawyer_names
      t.text     :judges_names
      t.text     :prosecutor_names
      t.date     :publish_on
      t.string   :content_file
      t.hstore   :crawl_data
      t.timestamps null: false
    end

    add_index :rules, :story_id
    add_index :rules, :publish_on
  end
end
