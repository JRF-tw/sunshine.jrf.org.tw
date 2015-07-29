class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :current
      t.string :avatar
      t.string :gender
      t.string :gender_source
      t.integer :birth_year
      t.string :birth_year_source
      t.integer :stage
      t.string :stage_source
      t.string :appointment
      t.string :appointment_source
      t.text :memo
      t.timestamps
    end

    add_index :profiles, :current
  end
end
