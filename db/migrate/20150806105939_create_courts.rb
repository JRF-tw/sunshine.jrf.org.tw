class CreateCourts < ActiveRecord::Migration
  def change
    create_table :courts do |t|
      t.string :court_type
      t.string :full_name
      t.string :name
      t.integer :weight
      t.timestamps
    end
    add_index :courts, :court_type
    add_index :courts, :full_name
    add_index :courts, :name
  end
end
