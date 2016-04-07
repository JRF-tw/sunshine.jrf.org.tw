class CreateLawyers < ActiveRecord::Migration
  def change
    create_table :lawyers do |t|
      t.string  :name
      t.string  :current
      t.string  :avatar
      t.string  :gender
      t.integer :birth_year
      t.string  :memo
      t.timestamps null: false
    end
  end
end
