class CreateProsecutors < ActiveRecord::Migration
  def change
    create_table :prosecutors do |t|
      t.string :name
      t.integer :prosecutors_office_id
      t.integer :judge_id
      t.string :avatar
      t.string :gender
      t.string :gender_source
      t.integer :birth_year
      t.string :birth_year_source
      t.integer :stage 
      t.string :stage_source
      t.string :appointment
      t.string :appointment_source
      t.string :memo
      t.boolean :is_active, default: true
      t.boolean :is_hidden, default: true
      t.boolean :is_judge
      t.timestamps null: false
    end
    add_index :prosecutors, :prosecutors_office_id
    add_index :prosecutors, :judge_id
    add_index :prosecutors, :is_judge
  end
end
