class CreatePunishments < ActiveRecord::Migration
  def change
    create_table :punishments do |t|
      t.integer :profile_id
      t.string :decision_unit
      t.string :unit
      t.string :title
      t.string :claimant
      t.string :no
      t.string :decision_no
      t.string :punish_type
      t.date :relevant_date
      t.text :decision_result
      t.string :decision_source
      t.text :reason
      t.boolean :is_anonymous
      t.string :anonymous_source
      t.string :anonymous
      t.text :origin_desc
      t.string :proposer
      t.string :plaintiff
      t.string :defendant
      t.text :reply
      t.string :reply_source
      t.string :punish
      t.text :content
      t.text :summary
      t.text :memo
      t.timestamps
    end
    add_index :punishments, :profile_id
  end
end
