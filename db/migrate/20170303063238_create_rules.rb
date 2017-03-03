class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.integer  :story_id
      t.string   :file
      t.text     :party_names
      t.text     :lawyer_names
      t.text     :judges_names
      t.text     :prosecutor_names
      t.date     :publish_date
      t.string   :content_file
      t.hstore   :crawl_data
      t.timestamps null: false
    end

    add_index :rules, :publish_date
  end
end
