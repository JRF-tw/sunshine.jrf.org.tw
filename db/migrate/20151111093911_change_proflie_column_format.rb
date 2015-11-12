class ChangeProflieColumnFormat < ActiveRecord::Migration
  def change
    change_column :profiles, :gender_source, :text
    change_column :profiles, :birth_year_source, :text
    change_column :profiles, :stage_source, :text
    change_column :profiles, :appointment_source, :text
  end
end
