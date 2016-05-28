class CreateJudges < ActiveRecord::Migration
  def change
    create_table :judges do |t|
      t.string  :name
      t.integer :current_court_id
      t.string  :avatar
      t.string  :gender
      t.string  :gender_source
      t.integer :birth_year
      t.string :birth_year_source
      t.integer :stage
      t.string :stage_source
      t.string :appointment
      t.string :appointment_source
      t.string :memo
      t.boolean :is_active
      t.boolean :is_hidden
      t.integer :punishments_count, default: 0
      t.timestamps null: false
    end
    add_index :judges, :current_court_id
    add_index :judges, :is_active
    add_index :judges, :is_hidden
  end
end
