class CreateProcedures < ActiveRecord::Migration
  def change
    create_table :procedures do |t|
      t.integer :profile_id
      t.integer :suit_id
      t.string :unit
      t.string :title
      t.string :procedure_unit
      t.text :procedure_content
      t.text :procedure_result
      t.string :procedure_no
      t.date :procedure_date
      t.integer :suit_no
      t.text :source
      t.string :source_link
      t.string :punish_link
      t.string :file
      t.text :memo
      t.timestamps
    end
    add_index :procedures, :profile_id
    add_index :procedures, :suit_id
  end
end
