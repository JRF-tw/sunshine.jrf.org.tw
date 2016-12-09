class CreateProsecutorsOffices < ActiveRecord::Migration
  def change
    create_table :prosecutors_offices do |t|
      t.string :full_name
      t.string :name
      t.integer :court_id
      t.boolean :is_hidden, default: true
      t.timestamps null: false
    end
    add_index :prosecutors_offices, :court_id
  end
end
